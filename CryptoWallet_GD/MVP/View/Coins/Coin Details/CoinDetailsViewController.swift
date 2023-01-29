//
//  CoinDetailsViewController.swift
//  CryptoWallet_GD
//
//  Created by Grisha Diehl on 10.12.2022.
//

import UIKit

class CoinDetailsViewController: UIViewController, Coordinating {

    private let container = CoinDetailsView()
    private let coin: Coin
    
    private let moneyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.formatterBehavior = .default
        formatter.numberStyle = .currency
        formatter.alwaysShowsDecimalSeparator = true
        
        return formatter
    }()
    
    private let percentFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.alwaysShowsDecimalSeparator = true
        
        return formatter
    }()
    
    var coordinator: Coordinator?
    
    init(coin: Coin) {
        self.coin = coin
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(container)
        view.backgroundColor = .black
        container.backgroundColor = .black
        
        title = "\(coin.data.name) Details"
        navigationController?.navigationBar.tintColor = .systemYellow
        
        setupConstraints()
        setupData()
    }
    
    private func setupConstraints() {
        let coinDetailsScreenElements = [container, container.coinImageView, container.symbolLabel, container.priceLabel, container.priceChangeLabel, container.marketCapitalizationLabel, container.marketCapitalizationDominanceLabel, container.coinRankLabel, container.allTimeHighPriceLabel, container.allTimeHighPercentChangeLabel]
        for element in coinDetailsScreenElements {
            element.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constraints = [
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            container.coinImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
            container.coinImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
            container.coinImageView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.3),
            container.coinImageView.heightAnchor.constraint(equalTo: container.coinImageView.widthAnchor),
            
            container.symbolLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 14),
            container.symbolLabel.trailingAnchor.constraint(equalTo: container.coinImageView.leadingAnchor, constant: -8),
            container.symbolLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            container.symbolLabel.heightAnchor.constraint(equalToConstant: 22),
            
            container.priceLabel.topAnchor.constraint(equalTo: container.symbolLabel.bottomAnchor, constant: 6),
            container.priceLabel.trailingAnchor.constraint(equalTo: container.symbolLabel.centerXAnchor),
            container.priceLabel.leadingAnchor.constraint(equalTo: container.symbolLabel.leadingAnchor),
            container.priceLabel.heightAnchor.constraint(equalToConstant: 22),
            
            container.priceChangeLabel.topAnchor.constraint(equalTo: container.symbolLabel.bottomAnchor, constant: 6),
            container.priceChangeLabel.trailingAnchor.constraint(equalTo: container.symbolLabel.trailingAnchor),
            container.priceChangeLabel.leadingAnchor.constraint(equalTo: container.priceLabel.trailingAnchor),
            container.priceChangeLabel.heightAnchor.constraint(equalToConstant: 22),
            
            container.marketCapitalizationLabel.topAnchor.constraint(equalTo: container.priceChangeLabel.bottomAnchor, constant: 36),
            container.marketCapitalizationLabel.trailingAnchor.constraint(equalTo: container.priceChangeLabel.trailingAnchor),
            container.marketCapitalizationLabel.leadingAnchor.constraint(equalTo: container.priceLabel.leadingAnchor),
            container.marketCapitalizationLabel.heightAnchor.constraint(equalToConstant: 44),
            
            container.marketCapitalizationDominanceLabel.topAnchor.constraint(equalTo: container.marketCapitalizationLabel.bottomAnchor, constant: 8),
            container.marketCapitalizationDominanceLabel.trailingAnchor.constraint(equalTo: container.marketCapitalizationLabel.trailingAnchor),
            container.marketCapitalizationDominanceLabel.leadingAnchor.constraint(equalTo: container.marketCapitalizationLabel.leadingAnchor),
            container.marketCapitalizationDominanceLabel.heightAnchor.constraint(equalToConstant: 44),
            
            container.coinRankLabel.topAnchor.constraint(equalTo: container.coinImageView.bottomAnchor, constant: 8),
            container.coinRankLabel.trailingAnchor.constraint(equalTo: container.coinImageView.trailingAnchor),
            container.coinRankLabel.leadingAnchor.constraint(equalTo: container.coinImageView.leadingAnchor, constant: -20),
            container.coinRankLabel.heightAnchor.constraint(equalToConstant: 22),
            
            container.allTimeHighPriceLabel.topAnchor.constraint(equalTo: container.marketCapitalizationDominanceLabel.bottomAnchor, constant: 36),
            container.allTimeHighPriceLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
            container.allTimeHighPriceLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            container.allTimeHighPriceLabel.heightAnchor.constraint(equalToConstant: 44),
            
            container.allTimeHighPercentChangeLabel.topAnchor.constraint(equalTo: container.allTimeHighPriceLabel.bottomAnchor, constant: 8),
            container.allTimeHighPercentChangeLabel.trailingAnchor.constraint(equalTo: container.allTimeHighPriceLabel.trailingAnchor),
            container.allTimeHighPercentChangeLabel.leadingAnchor.constraint(equalTo: container.allTimeHighPriceLabel.leadingAnchor),
            container.allTimeHighPercentChangeLabel.heightAnchor.constraint(equalToConstant: 22)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupData() {
        let priceChangeString = percentFormatter.string(from: NSNumber(
                                                        value: coin.data.marketData.percentChangeIn24Hours))
        let marketDominanceString = percentFormatter.string(from: NSNumber(
                                                            value: coin.data.marketcap.marketcapDominancePercent))
        let priceChange = coin.data.marketData.priceUsd / coin.data.allTimeHigh.price - 1

        container.coinImageView.image = UIImage(named: "\(coin.data.name)")
        container.symbolLabel.text = coin.data.symbol
        container.priceLabel.text = moneyFormatter.string(from: NSNumber(
                                                          value: coin.data.marketData.priceUsd))
        
        container.priceChangeLabel.text = "24h: \(priceChangeString ?? "-") %"
        container.marketCapitalizationLabel.text = "Market Capitalization\n" +
                                                    (moneyFormatter.string(from: NSNumber(
                                                    value: coin.data.marketcap.currentMarketcapUsd)) ?? "-")
        
        container.marketCapitalizationDominanceLabel.text = "Market Dominance\n" + "\(marketDominanceString ?? "-") %"
        container.coinRankLabel.text = "Market Rank: \(coin.data.marketcap.rank)"
        container.allTimeHighPriceLabel.text = "Historical Peak\n" + (moneyFormatter.string(
                                                from: NSNumber(value: coin.data.allTimeHigh.price)) ?? "-")
        
        container.allTimeHighPercentChangeLabel.text = (percentFormatter.string(from: NSNumber(
                                                                                value: priceChange)) ?? "-") + "%"
    }
}
