//
//  MainCoordinator.swift
//  CryptoWallet_GD
//
//  Created by Grisha Diehl on 25.11.2022.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController?

    func start() {
        let vc = SignInViewController()
        
        if UserDefaults.standard.bool(forKey: "signIn") == false {
            vc.coordinator = self
            navigationController?.setViewControllers([vc], animated: false)
        } else {
            let secondVC = CoinsSetViewController()
            secondVC.coordinator = self
            navigationController?.setViewControllers([secondVC], animated: false)
        }
    }

    func eventOccurred(with type: Event, coin: Coin?) {
        switch type {
        case .signInButtonTapped:
            var vc: UIViewController & Coordinating = CoinsSetViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
            
        case .signOutButtonTapped:
            var vc: UIViewController & Coordinating = SignInViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
            
        case .showCoinDetailsTapped:
            guard let coin = coin else { return }
            var vc: UIViewController & Coordinating = CoinDetailsViewController(coin: coin)
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

