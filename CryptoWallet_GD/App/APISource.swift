//
//  APICaller.swift
//  CryptoWallet_GD
//
//  Created by Grisha Diehl on 30.11.2022.
//

import Foundation

class APISource {
        
    struct Constants {
        static let baseURL = "https://data.messari.io/api/v1/assets/"
        
        enum CryptoCoinEndpoint: String, CaseIterable {
            case bitcoin = "bitcoin/metrics"
            case ethereum = "ethereum/metrics"
            case tron = "tron/metrics"
            case cardano = "cardano/metrics"
            case polkadot = "polkadot/metrics"
            case dogecoin = "dogecoin/metrics"
            case tether = "tether/metrics"
            case stellar = "stellar/metrics"
            case xrp = "xrp/metrics"
            case bnb = "binance-coin/metrics"
            case polygon = "polygon/metrics"
            case litecoin = "litecoin/metrics"
            case solana = "solana/metrics"
        }
    }
}


