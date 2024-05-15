//  ExchangeRate.swift
//
//  Handles currency rates functionalities, and delegates error handling
//
//  Created by Robin Reyes on 4/25/24
//

import Foundation

struct ExchangeRate: Codable {
    let from: String
    let to: String
    let rate: Float
}


// main struct that helps the exchange manager decode the data from API
struct ExchangeRateResponse: Codable {
    let data: [String: Float]
    
    // sends an object that has user's fromCurrency, toCurrency and rate values
    func toExchangeRate(from: String, to: String) -> ExchangeRate {
        return ExchangeRate(from: from, to: to, rate: data[to] ?? 0.0)
    }
}

// more error handling occurs below
enum ExchangeRateRequestErrorType {
    case server
    case client
    case decode
}

struct ExchangeRateRequestErrorDetail {
    let error: Error
    let type: ExchangeRateRequestErrorType
}


protocol ExchangeRateResponseDelegate {
    func reset()
    func requestFailedWith(error: Error?, type: ExchangeRateRequestErrorType)
}

class ExchangeRateDelegate: ExchangeRateResponseDelegate, ObservableObject {
    @Published var isErrorState: Bool = false
    @Published var errorDetail: ExchangeRateRequestErrorDetail? = nil
    
    // sets the error state back to false, making all views act normally
    // setting errorDetail to nil means no errors are present
    func reset() {
        DispatchQueue.main.async {
            self.isErrorState = false
            self.errorDetail = nil
        }
    }
    
    // helper function to help Exchange Manager decipher which error is happening
    // along with what message to send 
    func requestFailedWith(error: (any Error)?, type: ExchangeRateRequestErrorType) {
        DispatchQueue.main.async {
            self.isErrorState = true
            if let errMessage = error {
                self.errorDetail = ExchangeRateRequestErrorDetail(error: errMessage, type: type)
            }
        }
    }

}
