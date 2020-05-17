//
//  ReposViewModel.swift
//  Mogit
//
//  Created by Jan Provazník on 17/05/2020.
//  Copyright © 2020 Jan Provazník. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ReposViewModel {
    
    let git = GithubManager()
    let repos = BehaviorRelay<[Repo]>(value: [])
    
    func repos(username: String) {
        git.getRepos(username: username) { [unowned self] (repos, error) in
            if let repos = repos {
                self.repos.accept(repos)
            } else {
                self.repos.accept([])
            }
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
}
