//
//  ActionButton.swift
//  CryptoSwiftUI
//
//  Created by apple on 05/02/25.
//

import SwiftUI

struct ActionButton: View {
    let icon: String
    let title: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.blue)
            Text(title)
                .font(.caption)
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(icon: "bolt.fill", title: "Instant Buy")
    }
}
