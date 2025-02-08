//
//  PortfolioView.swift
//  CryptoSwiftUI
//
//  Created by apple on 06/02/25.
//

import SwiftUI

struct PortfolioView: View {
    var body: some View {
        NavigationView {
            VStack {
                // Top Navigation Tabs
                HStack {
                    Text("Coins")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Futures")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Image(systemName: "doc.on.doc")
                        .foregroundColor(.white)
                    Image(systemName: "message.fill")
                        .foregroundColor(.green)
                    Image(systemName: "square.and.arrow.down")
                        .foregroundColor(.white)
                }
                .padding()
                
                // Investment Summary Card
                VStack(spacing: 10) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Current")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("₹4,511.80")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Invested")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("₹4,912.00")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                    }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Returns")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("-₹400.20")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Total Returns %")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("-8.14%")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                        }
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
                .padding(.horizontal)
                
                // Info Alert
                HStack {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.orange)
                    Text("Your investment returns may be indicative")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.horizontal)

                // Invested Coins List
                List {
                    InvestmentCardView(
                        icon: "H",
                        name: "Hedera Hashgraph",
                        amount: "99.96173",
                        symbol: "HBAR",
                        returns: "-₹353.86",
                        current: "₹2,258.14",
                        invested: "₹2,612.00",
                        color: .black
                    )
                    .listRowSeparator(.hidden)
                    
                    InvestmentCardView(
                        icon: "S",
                        name: "Solana",
                        amount: "0.0999",
                        symbol: "SOL",
                        returns: "-₹121.70",
                        current: "₹1,878.30",
                        invested: "₹2,000.00",
                        color: .blue
                    )
                    .listRowSeparator(.hidden)
                    
                    InvestmentCardView(
                        icon: "E",
                        name: "EMAIL Token",
                        amount: "202.9",
                        symbol: "EMT",
                        returns: "+₹75.36",
                        current: "₹375.36",
                        invested: "₹300.00",
                        color: .blue
                    )
                    .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white]), startPoint: .top, endPoint: .center))
            .navigationBarHidden(true)
        }
    }
}

// Investment Row Component
struct InvestmentCardView: View {
    let icon: String
    let name: String
    let amount: String
    let symbol: String
    let returns: String
    let current: String
    let invested: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header: Coin Icon, Name, Amount, Arrow
            HStack {
                Circle()
                    .fill(Color.black)
                    .frame(width: 40, height: 40)
                    .overlay(Text(icon).foregroundColor(.white).font(.title2))
                    Text(name)
                        .font(.headline)
                Spacer()
                HStack {
                    Text(amount)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(symbol)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            Divider()
            
            // Returns, Current, Invested Values
            HStack {
                VStack(alignment: .leading) {
                    Text("Returns")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(returns)
                        .font(.body)
                        .foregroundColor(returns.contains("-") ? .red : .green)
                }
                
                Spacer()
                VStack(alignment: .leading) {
                    Text("Current")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(current)
                        .font(.body)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Invested")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(invested)
                        .font(.body)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

// Preview
struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}

