//
//  PortfolioView.swift
//  CryptoSwiftUI
//
//  Created by apple on 06/02/25.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            Text("Portfolio")
        }
        .padding()

    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}
