//
//  TabItem.swift
//  CryptoSwiftUI
//
//  Created by apple on 05/02/25.
//

import SwiftUI

struct TabItem: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(isSelected ? .blue : .gray)
            .underline(isSelected, color: .blue)
            .frame(maxWidth: .infinity)
    }
}
