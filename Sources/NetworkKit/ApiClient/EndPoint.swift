//
//  EndPointConvert.swift
//  MovieZoo
//
//  Created by Imran on 2/9/23.
//

import Foundation

struct EndPoint: EndPointConvertible {
    let url: String
    let parameters: Parameters?
    let headers: Headers?
    let method: HTTPMethod
    let contentType: String // Add content type here

    init(url: String, parameters: Parameters? = nil, headers: Headers? = nil, method: HTTPMethod = .get, contentType: String = "application/json") {
        self.url = url
        self.parameters = parameters
        self.headers = headers
        self.method = method
        self.contentType = contentType // Set the content type
    }
}
