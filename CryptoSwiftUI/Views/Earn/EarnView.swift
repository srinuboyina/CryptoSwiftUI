//
//  EarnView.swift
//  CryptoSwiftUI
//
//  Created by apple on 08/02/25.
//

import SwiftUI

struct EarnView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            // Top Left Button
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                            .padding()
                    }
                    Spacer()
                }
                Spacer()
            }
            // Centered Text
            Text("Earn")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)


        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.white.ignoresSafeArea()) // Background color
    }
}

struct EarnView_Previews: PreviewProvider {
    static var previews: some View {
        EarnView()
    }
}
