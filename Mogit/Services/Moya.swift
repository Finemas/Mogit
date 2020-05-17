//
//  Moya.swift
//  Mogit
//
//  Created by Jan Provazník on 17/05/2020.
//  Copyright © 2020 Jan Provazník. All rights reserved.
//

import Foundation

import Moya

enum ApiService {
    case getRepos(username: String)
}

extension ApiService: TargetType {
    var baseURL: URL { return URL(string: "https://api.github.com")! }
    
    var path: String {
        switch self {
        case .getRepos(let username):
            return "/users/\(username)/repos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRepos:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getRepos:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? { ["Content-Type:": "application/json"] }
}
