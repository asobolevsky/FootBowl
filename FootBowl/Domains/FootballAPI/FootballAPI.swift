//
//  FootballAPI.swift
//  FootBowl
//
//  Created by Aleksei Sobolevskii on 2024-06-13.
//

import Foundation

enum FootballAPI: Endpoint {
    case leagues(search: String? = nil)

    var path: String {
        switch self {
        case .leagues: return "/v3/leagues"
        }
    }


    var method: HTTPMethod {
        switch self {
        case .leagues: .GET
        }
    }

    var headers: [String : String]? {
        return nil
    }

    var parameters: [String : String]? {
        switch self {
        case .leagues(let search):
            ["search": search]
                .compactMapValues { $0 }
                .nilIfEmpty
        }
    }

}
