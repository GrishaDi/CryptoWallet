//
//  Coordinator.swift
//  CryptoWallet_GD
//
//  Created by Grisha Diehl on 25.11.2022.
//

import Foundation
import UIKit

enum Event {
    case signInButtonTapped
    case signOutButtonTapped
    case showCoinDetailsTapped
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }

    func start()

    func eventOccurred(with type: Event, coin: Coin?)
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
