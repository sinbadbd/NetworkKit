//
//  EndPointConvertible.swift
//  MovieZoo
//
//  Created by Imran on 2/9/23.
//

import Foundation

public typealias Headers = [String: String]
public typealias Parameters = [String: Any]

public protocol EndPointConvertible {
    var url: String { get }
    var parameters: Parameters? { get }
    var headers: Headers? { get }
    var method: HTTPMethod { get }
    //var token: String { get }
}
