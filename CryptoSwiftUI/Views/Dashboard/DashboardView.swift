//
//  DashboardView.swift
//  CryptoCoins
//
//  Created by apple on 05/02/25.
//

import SwiftUI

struct DashboardView: View {
    @State private var searchText: String = ""
    @State private var selectedTab: Int = 0
    @State private var isLoading: Bool = true
    @State private var showSearches = false
    @State private var showProfile = false
    @State private var showCoinDetails = false
    @State private var selectedCoin: Coin?
    
    @StateObject var coinsVM: CoinListViewModel = CoinListViewModel()
    
    var body: some View {
        VStack {
            // Top Bar
            HStack {
                // Profile Icon
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding()
                    .onTapGesture {
                        showProfile = true
                    }
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    Text("Search ETH 🔥")
                        .foregroundColor(.gray)
                        .font(.body)
                        .onTapGesture {
                            showSearches = true
                        }
                    Spacer()
                }
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
                
                // Notification Icon
                VStack {
                    Image("bell")
                        .frame(width:30, height:30)
                        .foregroundColor(.red)
                        .overlay(
                            Text("10")
                                .font(.caption2)
                                .foregroundColor(.white)
                                .padding(4)
                                .background(Color.red)
                                .clipShape(Circle())
                                .offset(x: 10, y: -10),
                            alignment: .topTrailing
                        )
                }
                .padding(.trailing)
            }
            
            // Banner
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue)
                .frame(height: 100)
                .overlay(
                    HStack {
                        Image(systemName: "percent")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()
                        Text("Lowest fees. Bigger profits\nTrade Futures at the lowest brokerage")
                            .foregroundColor(.white)
                            .font(.body)
                        Spacer()
                        Image(systemName: "arrow.right.circle.fill")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                    .padding()
                )
                .padding(.horizontal)
            
            // Action Buttons
            HStack {
                ActionButton(icon: "bolt.fill", title: "Instant Buy")
                ActionButton(icon: "dollarsign.circle.fill", title: "Earn")
                ActionButton(icon: "calendar", title: "SIP")
                ActionButton(icon: "arrow.right.arrow.left.circle", title: "Orders")
            }
            .padding()
            
            // Funds Card
            HStack {
                Image(systemName: "wallet.pass.fill")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                VStack(alignment: .leading) {
                    Text("Funds")
                        .font(.headline)
                    Text("₹0")
                        .foregroundColor(.gray)
                }
                Spacer()
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundColor(.blue)
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding(.horizontal)
            
            // Tabs (Gainers and Losers) with Swipe
            VStack {
                HStack {
                    Text("Gainers")
                        .font(.headline)
                        .foregroundColor(selectedTab == 0 ? .blue : .gray)
                        .onTapGesture {
                            selectedTab = 0
                        }
                        .frame(maxWidth: .infinity)
                    
                    Text("Losers")
                        .font(.headline)
                        .foregroundColor(selectedTab == 1 ? .blue : .gray)
                        .onTapGesture {
                            selectedTab = 1
                        }
                        .frame(maxWidth: .infinity)
                }
                .padding(.vertical)
                
                // Swipeable TabView
                TabView(selection: $selectedTab) {
                    // Gainers List
                    VStack {
                        if isLoading {
                            // Show Loader while loading
                            ProgressView("Loading data...")
                                .progressViewStyle(CircularProgressViewStyle())
                                .padding()
                        } else {
                            List {
                                ForEach(coinsVM.gainers(), id: \.symbol) { coin in
                                    CoinRow(name: coin.name, symbol: coin.symbol, price: coin.price, change: coin.change)
                                        .onTapGesture {
                                            selectedCoin = coin // Set the selected coin
                                            showCoinDetails = true // Show sheet
                                        }
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .tag(0) // Gainers tag
                    .onAppear {
                        loadGainersData()
                    }
                    
                    // Losers List
                    List {
                        ForEach(coinsVM.loosers(), id: \.symbol) { coin in
                            CoinRow(name: coin.name, symbol: coin.symbol, price: coin.price, change: coin.change)
                                .onTapGesture {
                                    selectedCoin = coin // Set the selected coin
                                    showCoinDetails = true // Show sheet
                                }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .tag(1) // Losers tag
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Enable swipeable tabs
            }
            .padding(.horizontal)

        }
        .sheet(item: $selectedCoin) { coin in
            CoinDetailsView(coinVM: CoinViewModel(coin: coin))
        }
        .fullScreenCover(isPresented: $showSearches) {
            SearchView(coins: coinsVM.allCoins)
        }
        .fullScreenCover(isPresented: $showProfile) {
            ProfileView()
        }
        
    }
    
    func loadGainersData() {
          coinsVM.loadCoins()
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Simulate a 2-second delay
              isLoading = false
          }
      }
}

// MARK: - Preview

struct CryptoCoinsView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}

