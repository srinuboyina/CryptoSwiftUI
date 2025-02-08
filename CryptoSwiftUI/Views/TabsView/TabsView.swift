//
//  TabsView.swift
//  CryptoSwiftUI
//
//  Created by apple on 06/02/25.
//

import SwiftUI

struct TabsView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            NavigationStack {
                FavouritesView()
            }
            .tabItem {
                Image(systemName: "star")
                Text("Favorites")
            }
            .tag(1)
            
            Web3View()
                .tabItem {
                    Image(systemName: "globe")
                    Text("Web3")
                }
                .tag(2)
            PortfolioView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Portfolio")
                }
                .tag(3)
        }
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
