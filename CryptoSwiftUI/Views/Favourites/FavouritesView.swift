//
//  FavouritesView.swift
//  CryptoSwiftUI
//
//  Created by apple on 06/02/25.
//

import SwiftUI

struct FavouritesView: View {
    @State var coins: [Coin] = []
    @State private var selectedCoin: Coin? // Store the selected coin
    @State private var showDetail = false  // Control the sheet visibility
    
    var body: some View {
        VStack {
            List {
                ForEach(coins, id: \.symbol) { coin in
                    CoinRow(name: coin.name, symbol: coin.symbol, price: coin.price, change: coin.change)
                        .onTapGesture {
                                selectedCoin = coin
                                showDetail.toggle()
                           }
                }
            }
            .sheet(item: $selectedCoin) { coin in
                CoinDetailsView(coinVM: CoinViewModel(coin: coin))
            }
        }
        .onAppear(){
            if let coins1 = FavoriteService.shared.getAllFavorites() {
                coins = coins1
            }
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
