//
//  GithubEndpoint.swift
//  BasicNetwork
//
//  Created by MAXIM ZHELEZNYY on 01.03.2022.
//

import Foundation

enum GithubEndpoint {
    case getUserDetails(userName: String)
}

extension GithubEndpoint: Endpoint {

    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }

    var hostUrl: String {
        switch self {
        default:
            return "api.github.com"
        }
    }

    var path: String {
        switch self {
        case .getUserDetails(let userName):
            return "/users/\(userName)"
        }
    }

    var headers: [String : String] {
        switch self {
        default :
            return [:]
        }
    }

    var queryParameters: [URLQueryItem]? {
        switch self {
        default:
            return nil
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getUserDetails:
            return .get
        }
    }
}
