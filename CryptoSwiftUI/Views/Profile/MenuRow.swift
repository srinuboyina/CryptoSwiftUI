//
//  MenuRow.swift
//  CryptoSwiftUI
//
//  Created by apple on 07/02/25.
//

import SwiftUI

struct MenuRow: View {
    let title: String
    let icon: String
    var tag: String? = nil
    var tagColor: Color? = nil

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 25)

            Text(title)
                .font(.body)

            Spacer()

            if let tag = tag, let tagColor = tagColor {
                Text(tag)
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(6)
                    .background(tagColor)
                    .clipShape(Capsule())
            }

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 5)
    }
}

struct MenuRow_Previews: PreviewProvider {
    static var previews: some View {
        MenuRow(title: "Account Settings", icon: "settings")
    }
}
