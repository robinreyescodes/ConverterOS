//  Currency.swift
//
//  struct and class for the currencies we give the users to select from 
//
//  Created by Robin Reyes on 4/25/24


import Foundation

// creating an object that matches the syntax of the values from the api
struct Currency: Hashable {
    let code: String
    let symbol: String
    let flag: String
}

// storing a bunch of the currencies into a class so they can be accessible
// may add more in future
class CurrencyState {
    static let currencies: [Currency] = [
        Currency(code: "USD", symbol: "$", flag: "🇺🇸"),
        Currency(code: "EUR", symbol: "€", flag: "🇪🇺"),
        Currency(code: "GBP", symbol: "£", flag: "🇬🇧"),
        Currency(code: "CAD", symbol: "$", flag: "🇨🇦"),
        Currency(code: "MXN", symbol: "$", flag: "🇲🇽"),
        Currency(code: "PHP", symbol: "₱", flag: "🇵🇭"),
        Currency(code: "KRW", symbol: "₩", flag: "🇰🇷"),
        Currency(code: "AUD", symbol: "$", flag: "🇦🇺"),
        Currency(code: "JPY", symbol: "¥", flag: "🇯🇵"),
        Currency(code: "CNY", symbol: "¥", flag: "🇨🇳"),
        Currency(code: "TRY", symbol: "₺", flag: "🇹🇷"),
        
        
    ]
}
