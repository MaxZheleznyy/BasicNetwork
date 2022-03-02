//
//  Endpoint.swift
//  BasicNetwork
//
//  Created by MAXIM ZHELEZNYY on 01.03.2022.
//

import Foundation

protocol Endpoint {

    /// Connection scheme. For example https or http
    var scheme: String { get }

    /// Domain of our endpont. For example api.github.com
    var hostUrl: String { get }

    /// Endpoint path. For example /user/profile/1234
    var path: String { get }

    /// Headers dictionary. For example "locale": "canada"
    var headers: [String : String] { get }

    /// An array of URLQueryItem items. For example URLQueryItem(name: "token", value: "123456")
    var queryParameters: [URLQueryItem]? { get }

    /// GET, POST etc
    var method: HTTPMethod { get }

}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
