//
//  CoinsSetTableViewCell.swift
//  CryptoWallet_GD
//
//  Created by Grisha Diehl on 30.11.2022.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {
    
    static let identifier = "CryptoTableViewCell"
    
    // MARK: - UI Elements
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemYellow
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()

    private let percentChangeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemYellow
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center

        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    // MARK: - Override
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(percentChangeLabel)
        contentView.addSubview(priceLabel)
        
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.sizeToFit()
        percentChangeLabel.sizeToFit()
        priceLabel.sizeToFit()
    }
    
    // MARK: - UI Setup
    private func setupConstraints() {
        let nameLabelConstraints = [
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3)
        ]
        let priceLabelConstraints = [
            percentChangeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            percentChangeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            percentChangeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            percentChangeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3)
        ]
        let rankLabelConstraints = [
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: percentChangeLabel.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(nameLabelConstraints)
        NSLayoutConstraint.activate(priceLabelConstraints)
        NSLayoutConstraint.activate(rankLabelConstraints)
    }
    
    func configure(with viewModel: CryptoTableViewCellViewModel) {
        nameLabel.text = viewModel.name
        percentChangeLabel.text = String(viewModel.percentChange)
        priceLabel.text = String(viewModel.priceUSD)
    }
     
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        percentChangeLabel.text = nil
        priceLabel.text = nil
    }
}

    // MARK: - Cell Model
struct CryptoTableViewCellViewModel {
    let name: String
    let priceUSD: String
    let percentChange: String
}
