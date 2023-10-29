//
//  EndPointConvertible.swift
//  MovieZoo
//
//  Created by Imran on 2/9/23.
//

import Foundation

typealias Headers = [String: String]
typealias Parameters = [String: Any]

protocol EndPointConvertible {
    var url: String { get }
    var parameters: Parameters? { get }
    var headers: Headers? { get }
    var method: HTTPMethod { get }
}
