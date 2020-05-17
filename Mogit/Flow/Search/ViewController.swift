//
//  ViewController.swift
//  Mogit
//
//  Created by Jan Provazník on 17/05/2020.
//  Copyright © 2020 Jan Provazník. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let git = GithubManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
        git.getRepos { (repos, error) in
            print(repos)
        }
    }
}
