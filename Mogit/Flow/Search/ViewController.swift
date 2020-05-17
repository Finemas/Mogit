//
//  ViewController.swift
//  Mogit
//
//  Created by Jan Provazník on 17/05/2020.
//  Copyright © 2020 Jan Provazník. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    let viewModel = ReposViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
        setupView()
        setupBindings()
    }
    
    func setupView() {
        emptyView.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupBindings() {
        searchBar.rx.text
             .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
             .distinctUntilChanged()
             .subscribe(onNext: { [unowned self] query in
                 self.viewModel.repos(username: query!)
             }).disposed(by: disposeBag)

         tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BasicCell")
         
         viewModel.repos
            .subscribe { (_) in
                if self.viewModel.repos.value.isEmpty {
                    self.tableView.backgroundView = self.emptyView
                    self.tableView.separatorStyle = .none
                } else {
                    self.tableView.backgroundView = nil
                    self.tableView.separatorStyle = .singleLine
                }
            }.disposed(by: disposeBag)
         
         viewModel.repos
             .bind(to: tableView.rx.items(cellIdentifier: "BasicCell", cellType: UITableViewCell.self)) { row, repo, cell in
                 print(row)
                 cell.textLabel?.text = repo.name
             }.disposed(by: disposeBag)
    }
    
    private lazy var emptyView = UIView()
    private lazy var emptyLabel: UILabel = {
        let emptyLabel = UILabel()
        emptyLabel.text = "Can't find user."
        emptyLabel.numberOfLines = 0
        emptyLabel.textAlignment = .center
        emptyLabel.sizeToFit()
        return emptyLabel
    }()
}
