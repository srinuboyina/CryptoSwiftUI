//
//  FavouritesView.swift
//  CryptoSwiftUI
//
//  Created by apple on 06/02/25.
//

import SwiftUI

struct FavouritesView: View {
    @State var coins: [Coin] = []

    var body: some View {
        VStack {
            List {
                ForEach(coins, id: \.symbol) { coin in
                    CoinRow(name: coin.name, symbol: coin.symbol, price: coin.price, change: coin.change)
                }
            }
        }
        .onAppear(){
            if let coins1 = CoinListViewModel.getFavoriteCoins() {
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
