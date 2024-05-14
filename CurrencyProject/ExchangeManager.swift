//
//  ExchangeManager.swift
//  
//
//  Created by Robin Reyes on 4/25/24
//



import Foundation

// connecting the api from freecurrencyapi
class ExchangeManager {
    public var delegate: ExchangeRateDelegate? = nil
    // not best practice to have the api and the key here
    // using it here to just showcase the connection between the app the api
    let url = "https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_2jbNxceKoGwxfvOz0i5cfnxlY6ISdTD58yXq5cMr"


    
    func fetchRates(for currency: String, toCurrency: String, ifCompleted: @escaping (_ exchangeRate: ExchangeRate?) -> Void) {
        
        self.delegate?.reset() // makes sure the response is not in an error state
        
        let url = URL(string: "\(self.url)&base_currency=\(currency)&currencies=\(toCurrency)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // if error, connection to api led to error
            if let err = error {
                self.handleClientError(err)
                DispatchQueue.main.async {
                    ifCompleted(nil)
                }
                
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                self.handleServerError(response)
                DispatchQueue.main.async {
                    ifCompleted(nil)
                }
                return
            }
            
            // if no errors, continue on with code below
            if let mimeType = httpResponse.mimeType, mimeType == "application/json",
               let json = data {
                let rate = self.decodeResponse(json: json, for: currency, to: toCurrency)
                
                DispatchQueue.main.async {
                    ifCompleted(rate)
                }
                
            } else {
                self.handleDecodeError()
            }
            
        }
        task.resume()

    }
    
    // helper function to decode the JSON info we get from the API
    func decodeResponse(json: Data, for currency: String, to toCurrency: String) -> ExchangeRate? {
        do {
            let decoder = JSONDecoder()
            let exchangeRateResponse = try decoder.decode(ExchangeRateResponse.self, from: json)
            return exchangeRateResponse.toExchangeRate(from: currency, to: toCurrency)
        } catch {
            // handle decode error here as well
            self.handleDecodeError()
            return nil
        }
    }
    
    // handle client, server, decode error messages
    private func handleClientError(_ error: Error) {
        delegate?.requestFailedWith(error: error, type: .client);
    }

    private func handleServerError(_ response: URLResponse?) {
        let error = NSError(domain: "API Error", code: 141)
        delegate?.requestFailedWith(error: error, type: .server);
    }
    
    private func handleDecodeError() {
        let error = NSError(domain: "Decode Error", code: 141)
        delegate?.requestFailedWith(error: error, type: .decode);
    }
    
}

