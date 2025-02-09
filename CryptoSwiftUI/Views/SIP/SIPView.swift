//
//  SIPView.swift
//  CryptoSwiftUI
//
//  Created by apple on 08/02/25.
//

import SwiftUI


struct SIPView: View {
    @State private var selectedTab = "Start a SIP"
    @Environment(\.dismiss) var dismiss

    let cryptos = [
        Crypto(name: "Bitcoin", symbol: "BTC", growth: 52.53, logo: "bitcoin.logo"),
        Crypto(name: "Ethereum", symbol: "ETH", growth: 16.2, logo: "ethereum.logo"),
        Crypto(name: "Binance Coin", symbol: "BNB", growth: 27.1, logo: "binance.logo"),
        Crypto(name: "Ripple", symbol: "XRP", growth: 76.74, logo: "ripple.logo"),
        Crypto(name: "Cardano", symbol: "ADA", growth: 25.14, logo: "cardano.logo")
    ]

    var body: some View {
        NavigationView {
            VStack {
                // Banner Section
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Build Long Term Wealth with SIP")
                        .font(.title2)
                        .bold()
                    
                    Text("Invest small & regularly to meet your investment goals!")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Image("crypto_sip_banner") // Replace with actual image asset
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                }
                .padding()
                .frame(height: 100)

                // Benefits Section
                HStack {
                    BenefitView(icon: "calendar.badge.clock", text: "No stress of\ntiming the market")
                    BenefitView(icon: "chart.bar", text: "Build long\nterm wealth")
                    BenefitView(icon: "chart.line.uptrend.xyaxis", text: "Reduced risk in\nvolatile markets")
                }
                .padding(.horizontal)

                // Segmented Control
                Picker("", selection: $selectedTab) {
                    Text("Start a SIP").tag("Start a SIP")
                    Text("Manage SIPs").tag("Manage SIPs")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // Crypto List
                List(cryptos) { crypto in
                    HStack {
                        Image(systemName: "circle.fill") // Placeholder for logo
                            .foregroundColor(.orange)
                            .frame(width: 40, height: 40)

                        VStack(alignment: .leading) {
                            Text(crypto.name)
                                .font(.headline)
                            Text(crypto.symbol)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        VStack(alignment: .trailing) {
                            Text("+\(String(format: "%.2f", crypto.growth))%")
                                .font(.headline)
                                .foregroundColor(.green)
                            Text("in past 3Y")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 8)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("CRYPTO SIP")
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

// Reusable Benefit View
struct BenefitView: View {
    let icon: String
    let text: String

    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(.blue)
            
            Text(text)
                .font(.caption)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }
}

struct CryptoSIPView_Previews: PreviewProvider {
    static var previews: some View {
        SIPView()
    }
}

