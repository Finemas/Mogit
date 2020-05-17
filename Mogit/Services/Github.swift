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
    
    func getRepos(completion: @escaping ([Repo]?, Error?) -> ())
}

class GithubManager: Networkable {
    var provider = MoyaProvider<ApiService>()
    
    func getRepos(completion: @escaping ([Repo]?, Error?) -> ()) {
        provider.request(.getRepos(username: "Finemas")) { response in
            switch response.result {
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let posts = try decoder.decode([Repo].self, from: value.data)
                    completion(posts, nil)
                } catch let error {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
