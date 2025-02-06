//
//  SearchView.swift
//  CryptoSwiftUI
//
//  Created by apple on 05/02/25.
//

import SwiftUI

struct Search: Identifiable  {
    var id = UUID()
    let symbol: String
    let change: String
    let color: Color
}


struct SearchView: View {
    let recentSearches = ["HBAR", "EMT", "ETH", "BNB", "AVAX", "ADA", "SHIB", "DOT"]
    let topSearchesInCoins = [
        Search(symbol:"DOGE", change:"-2.22%", color:.red),
        Search(symbol:"SHIB", change:"+2.64%", color:.green),
        Search(symbol:"PEPE", change:"-0.83%", color:.red)
    ]
    let topSearchesInFutures = [
        Search(symbol:"1000SHIB • USDT", change:"+4.59%", color:.green),
        Search(symbol:"1000PEPE • USDT", change:"+0.71%", color:.green),
        Search(symbol:"TRUMP • USDT", change:"+10.80%", color:.green)
    ]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Back Button and Search Bar
            HStack {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundColor(.black)
                    .onTapGesture {
                        dismiss()
                    }
                
                
                TextField("Search from 500+ coins", text: .constant(""))
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
            }
            .padding()
            
            // Recent Searches
            VStack(alignment: .leading, spacing: 8) {
                Text("Recent Searches")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                // Recent Searches Tags
                WrapHStack(items: recentSearches) { item in
                    Text(item)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(15)
                        .foregroundColor(.black)
                }
                .frame(height: 100)
                .padding(.horizontal)
            }
            
            // Top Searches in Coins
            SectionHeader(title: "Top searches in Coins")
            
            HStack {
                ForEach(topSearchesInCoins, id: \.symbol) { coin in
                    VStack {
                        Text(coin.symbol)
                            .font(.headline)
                            .foregroundColor(.black)
                        Text(coin.change)
                            .font(.subheadline)
                            .foregroundColor(coin.color)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            
            // Top Searches in Futures
            SectionHeader(title: "Top searches in Futures")
            
            HStack {
                ForEach(topSearchesInFutures, id: \.symbol) { future in
                    VStack {
                        Text(future.symbol)
                            .font(.headline)
                            .foregroundColor(.black)
                        Text(future.change)
                            .font(.subheadline)
                            .foregroundColor(future.color)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .background(Color.white)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

// Custom Section Header
struct SectionHeader: View {
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: "flame.fill")
                .foregroundColor(.orange)
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
        }
        .padding(.horizontal)
    }
}

// WrapHStack for Dynamic Tags
struct WrapHStack<Content: View, T: Hashable>: View {
    let items: [T]
    let content: (T) -> Content

    init(items: [T], @ViewBuilder content: @escaping (T) -> Content) {
        self.items = items
        self.content = content
    }

    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
    }

    private func generateContent(in geometry: GeometryProxy) -> some View {
        var totalWidth: CGFloat = 0
        var rows: [[T]] = [[]]

        for item in items {
            let itemWidth: CGFloat = itemWidth(for: item) + 5 // Adding padding
            if totalWidth + itemWidth > geometry.size.width {
                totalWidth = 0
                rows.append([])
            }
            rows[rows.count - 1].append(item)
            totalWidth += itemWidth
        }

        return VStack(alignment: .leading, spacing: 8) {
            ForEach(rows.indices, id: \.self) { rowIndex in
                HStack(spacing: 8) {
                    ForEach(rows[rowIndex], id: \.self) { item in
                        content(item)
                    }
                }
            }
        }
    }

    private func itemWidth(for item: T) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 17, weight: .medium) // Match SwiftUI default font
        let attributes = [NSAttributedString.Key.font: font]
        let size = (String(describing: item) as NSString).size(withAttributes: attributes)
        return size.width < 60 ? 60 : size.width
    }

}

// MARK: - Preview

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

