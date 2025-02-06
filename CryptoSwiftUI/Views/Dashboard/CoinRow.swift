//
//  CoinRow.swift
//  CryptoSwiftUI
//
//  Created by apple on 05/02/25.
//

import SwiftUI

struct CoinRow: View {
    let name: String
    let symbol: String
    let price: String
    let change: String
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 40, height: 40)
                .foregroundColor(.gray.opacity(0.2))
                .overlay(Text(symbol.prefix(1)).font(.headline))
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text(symbol)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(price)
                    .font(.headline)
                Text(change)
                    .foregroundColor(change.contains("-") ? .red : .green)
            }
        }
        .padding(.vertical, 5)
    }
}
