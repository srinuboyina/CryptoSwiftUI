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
    private var isAscendingPrice = true
    private var isAscendingChange = true

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
        
        navigationItem.leftBarButtonItem = backButton
        
        //sort buttons
        
        let sortByPriceButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.up.arrow.down.circle"),
            style: .plain,
            target: self,
            action: #selector(sortByPriceTapped)
        )

        let sortByChangeButton = UIBarButtonItem(
            image: UIImage(systemName: "chart.bar.xaxis"),
            style: .plain,
            target: self,
            action: #selector(sortByChangeTapped)
        )

        navigationItem.rightBarButtonItems = [sortByPriceButton, sortByChangeButton]
    }

    @objc func backButtonTapped() {
        navigationController?.dismiss(animated: true)
    }
    
    @objc func sortByPriceTapped() {
        isAscendingPrice.toggle() // Toggle sorting order
        filteredCoins.sort {
            if isAscendingPrice {
               return (Double($0.price) ?? 0) < (Double($1.price) ?? 0)
            } else {
               return (Double($0.price) ?? 0) > (Double($1.price) ?? 0)
            }
        }
        tableView.reloadData()
    }
    
    @objc func sortByChangeTapped() {
        isAscendingChange.toggle() // Toggle sorting order
        filteredCoins.sort {
            if isAscendingChange {
               return (Double($0.change) ?? 0) < (Double($1.change) ?? 0)
            } else {
               return (Double($0.change) ?? 0) > (Double($1.change) ?? 0)
            }
        }
        tableView.reloadData()
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

