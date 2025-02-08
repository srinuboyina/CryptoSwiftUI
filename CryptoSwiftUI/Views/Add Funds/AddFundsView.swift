//
//  AddFundsView.swift
//  CryptoSwiftUI
//
//  Created by apple on 08/02/25.
//

import SwiftUI

struct AddFundsView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        HStack {
            Image(systemName: "arrow.left")
                .font(.title2)
                .foregroundColor(.black)
                .onTapGesture {
                    dismiss()
                }
            Text("Add Funds")
        }
    }
}

struct AddFundsView_Previews: PreviewProvider {
    static var previews: some View {
        AddFundsView()
    }
}
