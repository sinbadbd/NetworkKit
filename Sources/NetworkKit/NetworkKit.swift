//
//  NetworkService.swift
//  MovieZoo
//
//  Created by Imran on 2/9/23.
//

import Foundation
import SwiftUI
import Combine

@available(iOS 13.0, *)
public class NetworkKit {
    
    static public let shared = NetworkKit()
    
    public func request<T: Decodable>(_ endpoint: EndPointConvertible) -> AnyPublisher<T, Error> {
        
        var urlRequest = URLRequest(url: URL(string: endpoint.url)!)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.allHTTPHeaderFields = endpoint.headers
        
        if let parameters = endpoint.parameters {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters)
                urlRequest.httpBody = jsonData
            } catch {
                return Fail(error: error).eraseToAnyPublisher()
            }
        }
        
        // Start monitoring network
        NetworkMonitor.shared.startMonitoring()
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap({ [self] (data, response) -> Data in
                if let response = response as? HTTPURLResponse,
                   (200..<500).contains(response.statusCode) == false {
                    throw SessionError.statusCode(response)
                }
                appendData(data, urlRequest: urlRequest)
                return data
            })
            .mapError { error -> APIError in
                print("✅ URL:- \(urlRequest):- \(error)")
                return APIError.encodingError(error.localizedDescription)
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    func formatBytes(_ bytes: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useBytes, .useKB, .useMB, .useGB]
        formatter.countStyle = .file
        
        return formatter.string(fromByteCount: bytes)
    }
    
    public func handleCompletion(url: URL, completion: Subscribers.Completion<Error>){
        switch completion{
        case .finished:
            
            print("Get Api Response Successfully from URL:\n✅\(url) ")
        case .failure(let error):
            print("Failed Api Response from URL:\n🚫\(url) ")
            print("🚫bad response \(error.localizedDescription)🚫")
            print("|----------------------------- Type Mismatch--------------------------------------------|")
            dump(error)
            print("|-----------------------------------------------------------------------------------|")
        }
    }
    
    
    func appendData(_ data: Data, urlRequest: URLRequest) {
        print("\n")
        print("✅-----RESPONSE START----✅")
        // Get the HTTP method from the request
        let httpMethod = urlRequest.httpMethod
        
        let dataSizeInBytes = Int64(data.count)
        let formattedSize = self.formatBytes(dataSizeInBytes)
        print("Method: [\(httpMethod ?? "")]: Request:- \(urlRequest):- \(formattedSize)")
        print(data.prettyJson as Any)
        
        print("✅----RESPONSE END----✅")
        print("\n\n")
    }
}

extension Data {
    var prettyJson: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding:.utf8) else { return nil }
        
        return prettyPrintedString as NSString
    }
}
