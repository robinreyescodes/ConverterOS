//
//  Currency.swift
//
//
//  Created by Robin Reyes on 4/25/24


import Foundation

// creating an object that matches the syntax of the values from the api
struct Currency: Hashable {
    let code: String
    let symbol: String
    
}

// storing a bunch of the currencies into a class so they can be accessible
// may add more in future
class CurrencyState {
    static let currencies: [Currency] = [
        Currency(code: "USD", symbol: "$"),
        Currency(code: "EUR", symbol: "€"),
        Currency(code: "GBP", symbol: "£"),
        Currency(code: "CAD", symbol: "$"),
        Currency(code: "PHP", symbol: "₱"),
        Currency(code: "KRW", symbol: "₩"),
        Currency(code: "AUD", symbol: "$"),
        Currency(code: "JPY", symbol: "¥"),
        
        
    ]
}
