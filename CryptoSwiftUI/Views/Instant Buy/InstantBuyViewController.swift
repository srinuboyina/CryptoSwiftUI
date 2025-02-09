//
//  InstantBuyViewController.swift
//  CryptoSwiftUI
//
//  Created by apple on 09/02/25.
//

import UIKit

class InstantBuyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private var viewModel: CoinListViewModelProtocol!
    private var coins: [Coin] = []
    private var filteredCoins: [Coin] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Coins"
        view.backgroundColor = .white

        searchBar.delegate = self
        searchBar.placeholder = "Search Coins"
        navigationItem.titleView = searchBar
        setupNavigationBar()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.identifier)
        tableView.tableFooterView = UIView()

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        loadData()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false

        // Back Button
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .black // Change color if needed
        navigationItem.leftBarButtonItem = backButton
    }

    @objc func backButtonTapped() {
        navigationController?.dismiss(animated: true)
    }
    
    func setViewModel(viewModel: CoinListViewModelProtocol = CoinListViewModel()){
        self.viewModel = viewModel
    }
    
    
    private func loadData() {
        viewModel.onDataUpdate = {
            self.coins = self.viewModel.getCoinsForPage()
            self.filteredCoins = self.viewModel.getCoinsForPage()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        viewModel.loadCoins()
    }

    // MARK: - TableView DataSource & Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCoins.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.identifier, for: indexPath) as? CoinTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: filteredCoins[indexPath.row])
        return cell
    }

    // MARK: - Search Functionality

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredCoins = coins
        } else {
            filteredCoins = coins.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }
}

