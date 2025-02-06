//
//  CoinDetailsView.swift
//  CryptoCoins
//
//  Created by apple on 30/01/25.
//

import SwiftUI
import Charts


struct CoinDetailsView: View {
    @StateObject var coin: CoinViewModel
    @State private var isFavourite = false
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // Bitcoin Header
                HStack {
                    URLImageView(imageURL: coin.iconUrl)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.yellow)
                    
                    VStack {
                        Text(coin.name)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(coin.symbol)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    HStack {
                        Image(systemName: "star") // Favorite icon
                            .onTapGesture {
                                isFavourite.toggle()
                                
                            }
                            .foregroundColor(isFavourite ? .green : .none)
                        Image(systemName: "bell") // Notification icon
                        Image("whatsapp") // Share/WhatsApp icon
                            .frame(width: 30, height: 30)
                    }
                    .font(.title2)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 20)
                
                // Price Information
                VStack {
                    Text(coin.marketCap)
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Market Cap: \(coin.marketCap)")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                
                // 24H Performance Chart
                VStack {
                    Text("24H Performance")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    CryptoGraphView(cryptoData: coin.sparkline)
                        .frame(height: 250)
                        .cornerRadius(10)
                }
                .padding()
                
                VStack {
                    HStack {
                        StatisticView(title: "Change", value: coin.change)
                        StatisticView(title: "Rank", value: coin.rank)
                    }
                    
                    HStack {
                        StatisticView(title: "24h Volume", value: coin.volume24h)
                        StatisticView(title: "BTC Price", value: coin.btcPrice)
                    }
                }
                
            }
            .padding()
        }
    }
}

// Reusable Statistic View
struct StatisticView: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.black)
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.black.opacity(0.3))
        .cornerRadius(10)
    }
}


struct URLImageView: View {
    let imageURL: String

    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .empty:
                ProgressView() // Shows a loading indicator
            case .success(let image):
                image.resizable().scaledToFit()
            case .failure:
                Image(systemName: "bitcoinsign.circle.fill") // Placeholder in case of failure
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 100, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


struct CoinDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let coinVM = CoinViewModel(coin: Coin(name: "Bitcoin", price: "101869.62848858866", iconUrl: "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg", marketCap: "2018707438775", symbol: "BTC", volume24h: "30480070767", change: "-0.72", sparkline: ["102729.12325887769","102373.25518010987","103056.15638125224","102353.95503707482","102675.18875859388","102688.24870073471","102225.00174448552","102046.66920230465","101121.30783987479","100786.44740322708","101167.38187245067","101550.23524610775","101750.28213660786","101879.12124251049","101970.29779530701","102086.86221525777","102196.92421450581","102532.68537213831","102614.20337582636","102815.8123793487","102528.02031167001","102527.6738007753","102588.79819612217"], btcPrice: "1", rank: 2))
        CoinDetailsView(coin: coinVM)
    }
}
