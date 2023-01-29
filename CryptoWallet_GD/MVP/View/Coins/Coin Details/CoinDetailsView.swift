//
//  CoinDetailsView.swift
//  CryptoWallet_GD
//
//  Created by Grisha Diehl on 10.12.2022.
//

import UIKit

class CoinDetailsView: UIView {

    var coinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
                
        return imageView
    }()
    
    let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .systemYellow
        label.textAlignment = .center
        label.backgroundColor = .black

        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.backgroundColor = .black

        return label
    }()
    
    let priceChangeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemYellow
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.backgroundColor = .black

        return label
    }()
    
    let marketCapitalizationDominanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemYellow
        label.textAlignment = .center
        label.backgroundColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        
        return label
    }()
    
    let marketCapitalizationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.textAlignment = .center
        label.backgroundColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        
        return label
    }()
    
    let coinRankLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemYellow
        label.textAlignment = .center
        label.backgroundColor = .black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        
        return label
    }()
    
    let allTimeHighPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.textAlignment = .center
        label.backgroundColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        
        return label
    }()
    
    let allTimeHighPercentChangeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemYellow
        label.textAlignment = .center
        label.backgroundColor = .black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(coinImageView)
        addSubview(symbolLabel)
        addSubview(priceLabel)
        addSubview(priceChangeLabel)
        addSubview(marketCapitalizationDominanceLabel)
        addSubview(marketCapitalizationLabel)
        addSubview(coinRankLabel)
        addSubview(allTimeHighPriceLabel)
        addSubview(allTimeHighPercentChangeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
