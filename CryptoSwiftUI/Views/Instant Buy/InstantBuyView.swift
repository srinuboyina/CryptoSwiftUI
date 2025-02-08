//
//  InstantBuyView.swift
//  CryptoSwiftUI
//
//  Created by apple on 08/02/25.
//

import SwiftUI

struct InstantBuyView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        HStack {
            Image(systemName: "arrow.left")
                .font(.title2)
                .foregroundColor(.black)
                .onTapGesture {
                    dismiss()
                }
            Text("Instant Buy")
        }
    }
}

struct InstantBuyView_Previews: PreviewProvider {
    static var previews: some View {
        InstantBuyView()
    }
}
