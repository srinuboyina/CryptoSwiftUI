//
//  InstantBuyVCWrapper.swift
//  CryptoSwiftUI
//
//  Created by apple on 09/02/25.
//


import SwiftUI
import UIKit

struct InstantBuyViewControllerWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let viewModel = CoinListViewModel()
        let viewController = InstantBuyViewController()
        viewController.setViewModel(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // Update the UI if needed
    }
}
