////
////  ApiManager+Ext.swift
////  MovieZoo
////
////  Created by Imran on 12/9/23.
////
//
//import Foundation
//import Combine
//
//struct ErrorResponse: Codable {
//    let success: Bool
//    let errors: [String: String]
//}
////@available(iOS 13.0, *)
//extension ApiManager{
//
//    func formatBytes(_ bytes: Int64) -> String {
//        let formatter = ByteCountFormatter()
//        formatter.allowedUnits = [.useBytes, .useKB, .useMB, .useGB]
//        formatter.countStyle = .file
//        
//        return formatter.string(fromByteCount: bytes)
//    }
//}
///*
//extension ApiManager {
//    func handleCompletion(url: URL, completion: Subscribers.Completion<Error>){
//        switch completion{
//        case .finished:
//            
//            print("Get Api Response Successfully from URL:\n✅\(url) ")
//        case .failure(let error):
//            print("Failed Api Response from URL:\n🚫\(url) ")
//            print("🚫bad response \(error.localizedDescription)🚫")
//            print("|----------------------------- Type Mismatch--------------------------------------------|")
//            dump(error)
//            print("|-----------------------------------------------------------------------------------|")
//        }
//    }
//}*/
//
//extension ApiManager {
//    func handleCompletion<T: Decodable>(url: URL, completion: Subscribers.Completion<Error>, modelType: T.Type? = nil) {
//        switch completion {
//        case .finished:
//            print("Get Api Response Successfully from URL:\n✅\(url) ")
//        case .failure(let error):
//            print("Failed Api Response from URL:\n🚫\(url) ")
//            print("🚫bad response \(error.localizedDescription)🚫")
//            print("|----------------------------- Error Response --------------------------------------|")
//            
//            if let nsError = error as? NSError, nsError.domain == NSURLErrorDomain {
//                         if let responseData = nsError.userInfo[NSURLErrorFailingURLResponseDataErrorKey] as? Data {
//                             if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: responseData) {
//                                 // Handle the error response here
//                    print("Error Response: \(errorResponse)")
//                    if !errorResponse.success {
//                        // The request was not successful, handle individual errors
//                        for (field, message) in errorResponse.errors {
//                            print("Field: \(field), Error: \(message)")
//                        }
//                    }
//                } else {
//                    // Handle other errors or non-structured error responses here
//                    dump(error)
//                }
//            }
//            
//            print("|-----------------------------------------------------------------------------------|")
//        }
//    }
//}
//
//
//
//extension ApiManager {
//    
//    func appendData(_ data: Data, urlRequest: URLRequest) {
//        print("\n")
//        print("✅-----RESPONSE START----✅")
//        // Get the HTTP method from the request
//        let httpMethod = urlRequest.httpMethod
//        
//        let dataSizeInBytes = Int64(data.count)
//        let formattedSize = self.formatBytes(dataSizeInBytes)
//        print("Method: [\(httpMethod ?? "")]: Request:- \(urlRequest):- \(formattedSize)")
//        print(data.prettyJson as Any)
//        
//        print("✅----RESPONSE END----✅")
//        print("\n\n")
//    }
//}
//
//extension Data {
//    var prettyJson: NSString? {
//        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
//              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
//              let prettyPrintedString = String(data: data, encoding:.utf8) else { return nil }
//        
//        return prettyPrintedString as NSString
//    }
//}
