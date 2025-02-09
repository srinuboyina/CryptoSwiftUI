//
//  OrdersView.swift
//  CryptoSwiftUI
//
//  Created by apple on 08/02/25.
//

import SwiftUI

struct OrdersView: View {
    @State private var selectedTab = "Instant"
    @Environment(\.dismiss) var dismiss
    
    let orders = [
        Order(name: "EMAIL Token", symbol: "EMT", quantity: 202.908, price: 1.48, total: 301.77, time: "2 Feb '25, 2:18 PM", logo: "email.logo"),
        Order(name: "Solana", symbol: "SOL", quantity: 0.0999, price: 20013.01, total: 2011.80, time: "2 Feb '25, 2:16 PM", logo: "solana.logo"),
        Order(name: "Hedera Hashgraph", symbol: "HBAR", quantity: 99.9617, price: 26.13, total: 2627.41, time: "2 Feb '25, 2:15 PM", logo: "hedera.logo")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Order Type", selection: $selectedTab) {
                    Text("Instant").tag("Instant")
                    Text("Limit").tag("Limit")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                List(orders) { order in
                    HStack {
                        Image(systemName: "circle.fill") // Placeholder for token logo
                            .foregroundColor(.blue)
                            .frame(width: 40, height: 40)
                        
                        VStack(alignment: .leading) {
                            Text(order.name)
                                .font(.headline)
                            Text(order.time)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            HStack {
                                Text("Qty \(String(format: "%.6f", order.quantity)) \(order.symbol)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("₹\(String(format: "%.2f", order.total))")
                                .font(.headline)
                                .foregroundColor(.black)
                            Text("Price ₹\(String(format: "%.2f", order.price))")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 8)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Orders")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                    }
                }
            }
        }
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}

