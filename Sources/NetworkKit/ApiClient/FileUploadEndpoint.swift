//
//  FileUploadEndpoint.swift
//
//
//  Created by Imran on 30/10/23.
//

import Foundation

public struct FileUploadEndpoint: EndPointConvertible {
    
    public let url: String
    public let fileData: Data
    public let headers: Headers?
    public let method: HTTPMethod
    public var parameters: Parameters?

    public init(url: String, fileData: Data, headers: Headers?, method: HTTPMethod, parameters: Parameters? = nil) {
        self.url = url
        self.fileData = fileData
        self.headers = headers
        self.method = method
        self.parameters = parameters
    }
}
