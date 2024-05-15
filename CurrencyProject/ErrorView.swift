//  ErrorView.swift
//
//  View if any errors reaching server occur
//
//  Created by Robin Reyes on 4/30/24.
//

import SwiftUI

struct ErrorView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            Text("Oops, an error occured").font(.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                .padding()
            Group {
                
                Text("Cannot connect to server...").foregroundColor(.white)
                Text("Try again soon").foregroundColor(.white)
                
                Image("BrokenRobotIcon(White)")
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
    ErrorView()
}
