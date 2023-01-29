//
//  CoinsSetViewController.swift
//  CryptoWallet_GD
//
//  Created by Grisha Diehl on 23.11.2022.
//

import UIKit

class CoinsSetViewController: UIViewController, CoinsSetPresenterDelegate, Coordinating {

    // MARK: - Properties
    private let presenter = CoinsSetPresenter()
    private var coins = [Coin]()
    var coordinator: Coordinator?
    
    static let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.formatterBehavior = .default
        formatter.numberStyle = .currency
        formatter.alwaysShowsDecimalSeparator = true
        
        return formatter
    }()
    
    static let percentFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.alwaysShowsDecimalSeparator = true
        
        return formatter
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .systemYellow
        indicator.style = .large
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        return indicator
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CryptoTableViewCell.self,
                           forCellReuseIdentifier: CryptoTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Crypto List"
                
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(activityIndicator)
        
        setupNavigationBar()
        setupPopupMenu()
        setupSignOutButton()
        
        presenter.setViewDelegate(delegate: self)
        presenter.getAllCryptoData()
        presenter.isWorkIndicator(isAnimated: true, indicator: activityIndicator)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
        let indicatorConstraints = [
            activityIndicator.topAnchor.constraint(equalTo: navigationController?.navigationBar.topAnchor ?? view.safeAreaLayoutGuide.topAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ]
        NSLayoutConstraint.activate(indicatorConstraints)
    }
    
    private func setupPopupMenu() {
        let priceFromHighToLow = UIAction(title: "High to Low",
                                          image: UIImage(systemName: "arrow.down.circle")) { (action) in
            self.coins.sort(by: { $0.data.marketData.percentChangeIn24Hours > $1.data.marketData.percentChangeIn24Hours })
            self.tableView.reloadData()
        }
        let priceFromLowToHigh = UIAction(title: "Low to High",
                                          image: UIImage(systemName: "arrow.up.circle")) { (action) in
            self.coins.sort(by: { $0.data.marketData.percentChangeIn24Hours < $1.data.marketData.percentChangeIn24Hours })
            self.tableView.reloadData()
        }
        let menu = UIMenu(title: "Price Change in Recent 24h:", options: .displayInline,
                          children: [priceFromHighToLow, priceFromLowToHigh])
        
        navigationItem.rightBarButtonItem?.menu = menu
    }
    
    private func setupSignOutButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Sign Out",
            style: .done,
            target: self,
            action: #selector(didTapSignOut))
    }
    
    func presentCoins(coins: [Coin]) {
        self.coins = coins
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func dataUpdated() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        navigationController?.navigationBar.layer.zPosition = 0
    }
    
    @objc private func didTapSignOut () {
        let sheet = UIAlertController(title: "Sign Out",
                                      message: "Are you sure you'd like to sign out?",
                                      preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { [self] _ in
            coordinator?.eventOccurred(with: .signOutButtonTapped, coin: nil)
            UserDefaults.standard.set(false, forKey: "signIn")
        }))
        present(sheet, animated: true)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.tintColor = .systemYellow
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:
                                                                                UIColor.systemYellow]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:
                                                                            UIColor.systemYellow]
        navigationController?.navigationBar.layer.zPosition = -1
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "dollarsign.arrow.circlepath"),
                                                            style: .done,
                                                            target: self,
                                                            action: nil)
    }
}

    // MARK: - Table View Methods
extension CoinsSetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let priceFormatter = CoinsSetViewController.priceFormatter
        let percentFormatter = CoinsSetViewController.percentFormatter
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.identifier,
                                                       for: indexPath
        ) as? CryptoTableViewCell else {
            fatalError()
        }
        let coin = coins[indexPath.row]
        let price = coin.data.marketData.priceUsd
        let percentChange = coin.data.marketData.percentChangeIn24Hours
        let priceString = priceFormatter.string(from: NSNumber(value: price))
        let percentString = percentFormatter.string(from: NSNumber(value: percentChange))
        let model = CryptoTableViewCellViewModel(name: coin.data.name,
                                                 priceUSD: priceString ?? "-",
                                                 percentChange: "\(percentString ?? "-")" + "%")
        cell.configure(with: model)
        cell.accessoryType = .disclosureIndicator
        
        var background = cell.backgroundConfiguration
        background?.backgroundColor = .black
        cell.backgroundConfiguration = background
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
        let coin = coins[indexPath.row]
        coordinator?.eventOccurred(with: .showCoinDetailsTapped, coin: coin)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
