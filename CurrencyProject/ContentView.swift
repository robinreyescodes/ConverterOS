//  ContentView.swift
//
//  ConverterOS, a currency converter app that utilizes the freecurrencyapi
//  to converter any whole number amount into one of a number of selectable
//  options. Currencies are live currency values from around the world.
//
//  Created by Robin Reyes on 4/2/24
//

import SwiftUI

struct ContentView: View {
    @State var currencies = CurrencyState.currencies
    
    @State var amount: String = "100"
    @State var convertedAmount: String? = nil
    
    @State var fromCurrency: Currency = CurrencyState.currencies[0]
    
    @State var toCurrency: Currency = CurrencyState.currencies[1]
    
    @State var showErrorScreen = false
    
    @State var showCurrencyErrorScreen = false
    
    @State var isLoading = false
    
    @ObservedObject var errorDelegate = ExchangeRateDelegate()
    
    
    
    // convert string into number
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.decimalSeparator = "."
        return formatter
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("ConverterOS").font(.system(size: 32, weight: .bold)).foregroundColor(.green)
            
            Image("icons8-money-circulation-100")
                .resizable().frame(width:100, height:100)
            
            VStack(alignment:.center){
                Text("Enter Cash Amount").font(.title3).padding()
                TextField("", text: $amount)
                    .font(.system(size:22))
                    .fontWeight(.bold)
                    .padding(10)
                    .frame(width:350, height:50)
                    .border(.green)
                    .cornerRadius(12)
                    .multilineTextAlignment(.center)
                    
                    
            }
            HStack {
                VStack {
                    Text("From: ")
                    
                    Picker("From Currency: ", selection: $fromCurrency) {
                        ForEach(currencies, id: \.code) { currency in
                            Text("\(currency.code) \(currency.flag)").tag(currency)
                        }
                    }.accentColor(.green)
                }
                
                VStack {
                    Text("To:  ")
                    Picker("To Currency: ", selection: $toCurrency) {
                        ForEach(currencies, id: \.code) { currency in
                            Text("\(currency.code) \(currency.flag)").tag(currency)
                        }
                    }.accentColor(.green)
                }
            }

            
            Button(action: {
                // do conversion here
                convertCurrency()
            }, label: {
                Text("Convert!")
                    .frame(width:120, height: 40)
                    .foregroundColor(.white)
                    .background(.green)
                    .cornerRadius(12)
            })
            VStack {
                Text("\(amount)").font(.title2).fontWeight(.medium)
                Text("\(fromCurrency.code) \(fromCurrency.flag) to \(toCurrency.code) \(toCurrency.flag)").font(.title3)
            }
 
            
            HStack {
                if isLoading {
                    // data is loading
                    ProgressView()
                } else {
                    Text(getConvertedAmountString()).font(.title).foregroundColor(.white).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                
            }.frame(width:350, height: 80)
                .background(.green)
                .cornerRadius(12)
        }
        
        .padding(.top, 30).padding(.leading, 30).padding(.trailing, 30)
        .fullScreenCover(isPresented: $showCurrencyErrorScreen) {
            CurrencyError()
        }
        .fullScreenCover(isPresented: $showErrorScreen) {
            ErrorView()
        }
        .onChange(of: errorDelegate.isErrorState) { oldValue, newValue in
            if newValue {
                isLoading = false
                // show error screen here if data cannot be retrieved
                showErrorScreen = true
            }
        }
        
    }
    
    
    
    func getConvertedAmountString() -> String {
        // if there is an amount converted, return the symbol of fromCurrency
        return convertedAmount ?? "\(fromCurrency.symbol) \(amount)"
    }
    
    func convertCurrency() -> Void {
        // if the amount can't be turned into a number, just return
    
        guard let floatAmount = formatter.number(from: amount) as? Float else
        {
            showCurrencyErrorScreen = true
            return
        }
        
        
        
        // when user clicks convert, animation will run
        isLoading = true
 
        // connect to the api in the background and get the
        // converter amount that correlates with the selected values
        DispatchQueue.global(qos: .background).async {
            let rateManager = ExchangeManager()
            rateManager.delegate = errorDelegate
            rateManager.fetchRates(for: fromCurrency.code, toCurrency: toCurrency.code) { result in
      
                // if a positive status returns, do the conversion
                if let exchangeRate = result {
                    let convertedAmountFloat = exchangeRate.rate * floatAmount
                    let convertedAmountString = formatter.string(from: NSNumber(value:
                                                                            convertedAmountFloat)) ?? "0.00"
                    // return everything back to normal
                    DispatchQueue.main.async {
                        // when given result, isLoading goes back to default state
                        isLoading = false
                        self.convertedAmount = "\(toCurrency.symbol) \(convertedAmountString)"
                    }
                }
            }
            
        }

    }
}

#Preview {
    ContentView()
}
