//
//  EndPointConvert.swift
//  MovieZoo
//
//  Created by Imran on 2/9/23.
//

import Foundation

public struct EndPoint: EndPointConvertible {
    
    public let url: String
    public let parameters: Parameters?
    public let headers: Headers?
    public let method: HTTPMethod
    public let contentType: String // Add content type here

   public init(url: String, parameters: Parameters? = nil, headers: Headers? = nil, method: HTTPMethod = .get, contentType: String = "application/json") {
        self.url = url
        self.parameters = parameters
        self.headers = headers
        self.method = method
        self.contentType = contentType // Set the content type
    }
}
