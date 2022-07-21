//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Арстан on 14/6/22.
//

import Foundation
struct CoinModel {
    let valueName : String
    let lastPrice : Double

var priceString : String {
    return String(format: "%.1f", lastPrice)
}

}
