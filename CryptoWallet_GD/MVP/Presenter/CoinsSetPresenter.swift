//
//  CoinsSetPresenter.swift
//  CryptoWallet_GD
//
//  Created by Grisha Diehl on 05.12.2022.
//

import Foundation
import UIKit

class CoinsSetPresenter {
    
    private let apiSource = APISource()
    private var allCoins = [Coin]()
    
    weak var delegate: CoinsSetPresenterDelegate?
    
    public func setViewDelegate(delegate: CoinsSetPresenterDelegate) {
        self.delegate = delegate
    }
    
    public func getAllCryptoData() {
        let group = DispatchGroup()
        
        for coin in APISource.Constants.CryptoCoinEndpoint.allCases {
            guard let url = URL(string: APISource.Constants.baseURL + coin.rawValue) else { continue }
            
            group.enter()
            let task = URLSession.shared.dataTask(with: url) { [self] data, _, error in
                defer {
                    group.leave()
                }
                guard let data = data, error == nil else { return }
                do {
                    let crypto = try JSONDecoder().decode(Coin.self, from: data)
                    allCoins.append(crypto)
                }
                catch {
                    print("Error: \(error)")
                }
            }
            task.resume()
        }
        group.notify(queue: .main) {
            self.delegate?.presentCoins(coins: self.allCoins)
            self.delegate?.dataUpdated()
        }
    }
    
    public func isWorkIndicator(isAnimated: Bool, indicator: UIActivityIndicatorView ) {
        if isAnimated {
            indicator.startAnimating()
            indicator.isHidden = false
        } else {
            indicator.stopAnimating()
            indicator.isHidden = true
        }
    }
}

protocol CoinsSetPresenterDelegate: AnyObject {
    func presentCoins(coins: [Coin])
    
    func dataUpdated()
}
