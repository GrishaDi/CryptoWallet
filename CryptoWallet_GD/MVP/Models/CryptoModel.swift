//
//  Crypto.swift
//  CryptoWallet_GD
//
//  Created by Grisha Diehl on 01.12.2022.
//

import Foundation

struct Coin: Codable {
    let data: CoinData
}

struct CoinData: Codable {
    let symbol: String
    let name: String
    let marketData: MarketData
    let marketcap: MarketCap
    let allTimeHigh: AllTimeHigh

    enum CodingKeys: String, CodingKey {
        case symbol, name, marketcap
        case marketData = "market_data"
        case allTimeHigh = "all_time_high"
    }
}

struct MarketData: Codable {
    let priceUsd: Double
    let percentChangeIn24Hours: Double

    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case percentChangeIn24Hours = "percent_change_usd_last_24_hours"
    }
}

struct MarketCap: Codable {
    let rank: Int
    let marketcapDominancePercent, currentMarketcapUsd: Double

    enum CodingKeys: String, CodingKey {
        case rank
        case marketcapDominancePercent = "marketcap_dominance_percent"
        case currentMarketcapUsd = "current_marketcap_usd"
    }
}

struct AllTimeHigh: Codable {
    let price: Double
    let percentDown: Double

    enum CodingKeys: String, CodingKey {
        case price
        case percentDown = "percent_down"
    }
}
