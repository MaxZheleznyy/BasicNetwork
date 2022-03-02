//
//  NetworkService.swift
//  BasicNetwork
//
//  Created by MAXIM ZHELEZNYY on 01.03.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Codable>(endpoint: Endpoint, completion: @escaping ResultBlock<T, Error>)
}

final class NetworkService: NetworkServiceProtocol {

    /// Executes the web call and will decode the JSON response into the Codable object provided
    /// - Parameters:
    ///     - endpoint: the endpoint to make the HTTP(S) request against
    ///     - completion: the JSON response converted to the provided Codable object, if successful, or failure otherwise
    func request<T: Codable>(endpoint: Endpoint, completion: @escaping ResultBlock<T, Error>) {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.hostUrl
        components.path = endpoint.path
        if let queryItems = endpoint.queryParameters {
            components.queryItems = queryItems
        }

        guard let url = components.url else {
            //TODO: - Add logger or another way to debug
            let error = NSError(
                domain: "",
                code: 404,
                userInfo: [NSLocalizedDescriptionKey: "Failed to get request url"]
            )
            completion(.failure(error))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.allHTTPHeaderFields = endpoint.headers

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

            if let error = error {
                //TODO: - Add logger or another way to debug
                completion(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                //TODO: - Add logger or another way to debug
                let error = NSError(
                    domain: "",
                    code: 404,
                    userInfo: [NSLocalizedDescriptionKey: "No response or error code"]
                )
                completion(.failure(error))
                return
            }

            guard let data = data else {
                //TODO: - Add logger or another way to debug
                let error = NSError(
                    domain: "",
                    code: 404,
                    userInfo: [NSLocalizedDescriptionKey: "Request doesn't return data or error"]
                )
                completion(.failure(error))
                return
            }

            do {
                let responseObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(responseObject))
            } catch let error as NSError {
                //TODO: - Add logger or another way to debug
                completion(.failure(error))
            }
        }.resume()
    }
}
