//
//  Github.swift
//  Mogit
//
//  Created by Jan Provazník on 17/05/2020.
//  Copyright © 2020 Jan Provazník. All rights reserved.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<ApiService> { get }

    func getRepos(username: String, completion: @escaping ([Repo]?, Error?) -> ())
}

class GithubManager: Networkable {
    var provider = MoyaProvider<ApiService>()
    
    func getRepos(username: String, completion: @escaping ([Repo]?, Error?) -> ()) {
        print(username)
        provider.request(.getRepos(username: username)) { response in
            switch response.result {
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let repos = try decoder.decode([Repo].self, from: value.data)
                    completion(repos, nil)
                } catch let error {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
