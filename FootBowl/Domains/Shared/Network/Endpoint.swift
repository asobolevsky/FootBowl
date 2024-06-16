//
//  Endpoint.swift
//  FootBowl
//
//  Created by Aleksei Sobolevskii on 2024-06-13.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
}

enum EndpointError: Error {
    case failedToCreateURL
    case failedToEncodeParameters
}

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: String]? { get }
}

extension Endpoint {
    func buildRequest(with host: String) throws(EndpointError) -> URLRequest {
        guard let url = URL(string: host + path) else {
            throw .failedToCreateURL
        }

        var request = URLRequest(url: url)
        if let parameters {
            switch method {
            case .GET:
                let queryItems = parameters
                    .map { $0 }
                    .map { URLQueryItem(name: $0.key, value: $0.value) }
                    .reduce(into: []) { $0.append($1) }
                if !queryItems.isEmpty {
                    var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
                    urlComponents?.queryItems = queryItems
                    request.url = urlComponents?.url
                }

            case .POST:
                do {
                    let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
                    request.httpBody = data
                } catch {
                    throw .failedToEncodeParameters
                }
            }
        }

        headers?
            .map { $0 }
            .forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }

        return request
    }
}
