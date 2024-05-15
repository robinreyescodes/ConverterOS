//  CurrencyError.swift
//
//  View if user's currency input is not correct
//
//  Created by Robin Reyes on 4/30/24
//

import SwiftUI

struct CurrencyError: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            Spacer()
            Text("Incorrect Input Type!").font(.title).foregroundColor(.white).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding()
            Group {
                
                Text("Please enter valid amount").foregroundColor(.white)
                Text("Commas are okay...").foregroundColor(.white)
                Image("ErrorIconWhite")
                    .resizable().frame(width:100, height:100)
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Go back")
                        .frame(width:350, height:50)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(200)
                })
            }.multilineTextAlignment(.center)
        }
        .padding(3)
        .frame(width:500)
        .background(.green)
        
            
    }
}

#Preview {
    CurrencyError()
}
