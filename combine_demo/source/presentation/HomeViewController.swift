//
//  ViewController.swift
//  combine_demo
//
//  Created by New Danish on 18/07/2024.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    private var loader: UIActivityIndicatorView!
    private var tableView: UITableView!
    private var viewModel: HomeViewModel? = nil
    
    private var cancellable: AnyCancellable? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = HomeViewModel(fetchUsersUsecase: FetchUsersUsecase(repository: UserRepository()))
        self.setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewModel?.fetchUsers()
    }
    
    private func setupTableView() {
        tableView = UITableView()
        self.view.addSubview(self.tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.loader = UIActivityIndicatorView()
        self.loader.backgroundColor = .green
        self.view.addSubview(self.loader)
        self.loader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.loader.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200),
            self.loader.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        ])
        
        self.loader.startAnimating()
        self.cancellable = self.viewModel?.$users
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let failure):
                    print("Finished with failure \(failure)")
                }
            }, receiveValue: { _ in
                self.loader.stopAnimating()
                self.tableView.reloadData()
            })
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.users.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        tableViewCell.textLabel?.text = self.viewModel?.users[indexPath.row].name ?? "No Name"
        return tableViewCell
    }
    
    
}
