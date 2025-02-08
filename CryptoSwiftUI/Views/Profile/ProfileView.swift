//
//  ProfileView.swift
//  CryptoSwiftUI
//
//  Created by apple on 07/02/25.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // User Info Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Boyina Srinivasarao")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("sri****yin@gmail.com")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    HStack {
                        Text("UID: BO14037768")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Image(systemName: "doc.on.doc") // Copy icon
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                
                // Funds Section
                HStack {
                    VStack(alignment: .leading) {
                        Text("Funds")
                            .font(.caption)
                            .foregroundColor(.gray)
                        HStack {
                            Text("₹0")
                                .font(.title3)
                                .fontWeight(.bold)
                            Text("• ₹0")
                                .font(.title3)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                    Image(systemName: "chevron.right") // Navigation arrow
                        .foregroundColor(.gray)
                }
                .padding()
                .padding(.horizontal)

                // Menu Options
                List {
                        MenuRow(title: "Account Settings", icon: "person.circle", tag: "KYC ACTIVE", tagColor: .green)
                        MenuRow(title: "All Orders", icon: "doc.text")
                        MenuRow(title: "Security", icon: "lock.shield")
                        MenuRow(title: "Price Alerts", icon: "bell")

                        MenuRow(title: "Tax Report with", icon: "doc.plaintext", tag: "KoinX", tagColor: .blue)
                        MenuRow(title: "Generate Report", icon: "arrow.down.doc", tag: "CLAIM TDS", tagColor: .green)
                }

                // Bottom Navigation Switch
                HStack {
                    Spacer()
                    Text("Lite")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .clipShape(Capsule())

                    Spacer()
                    
                    Text("Pro")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .clipShape(Capsule())
                    
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {}) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.black)
                    .onTapGesture {
                        dismiss()
                    }
            })
        }
    }
}

// Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

