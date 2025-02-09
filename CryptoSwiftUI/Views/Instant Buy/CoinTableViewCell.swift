//
//  CoinTableViewCell.swift
//  CryptoSwiftUI
//
//  Created by apple on 09/02/25.
//

import UIKit
import SDWebImage


class CoinTableViewCell: UITableViewCell {

    static let identifier = "CoinTableViewCell"

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()

    private let changeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let labelsStack = UIStackView(arrangedSubviews: [nameLabel, symbolLabel])
        labelsStack.axis = .vertical
        labelsStack.spacing = 2

        let rightStack = UIStackView(arrangedSubviews: [priceLabel, changeLabel])
        rightStack.axis = .vertical
        rightStack.alignment = .trailing
        rightStack.spacing = 2

        let mainStack = UIStackView(arrangedSubviews: [iconImageView, labelsStack, rightStack])
        mainStack.axis = .horizontal
        mainStack.spacing = 12
        mainStack.alignment = .center

        contentView.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true

        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with coin: Coin) {
        if let url = URL(string: coin.iconUrl) {
            iconImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "bitcoinsign.circle"))
        }
        nameLabel.text = coin.name
        symbolLabel.text = coin.symbol
        priceLabel.text = coin.price
        changeLabel.text = coin.change
        if let change = Double(coin.change) {
            changeLabel.text = "\(change)%"
            changeLabel.textColor = change >= 0 ? .systemGreen : .systemRed
        }
    }
}

