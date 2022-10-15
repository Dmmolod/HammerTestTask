//
//  ProductTableViewCell.swift
//  HammerTestTask
//
//  Created by Дмитрий Молодецкий on 13.10.2022.
//

import UIKit

final class ProductTableViewCell: UITableViewCell {
    
    private let productImageView = UIImageView()
    private let productNameLabel = UILabel()
    private let productDescriptionLabel = UILabel()
    private let addProductToBasketButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        addSubviews()
        applyConstraints()
        setupUI()
        
        addProductToBasketButton.setTitle("от 345 р", for: .normal)
    }
    required init?(coder: NSCoder) { nil }
    
    func configure(_ model: Product) {
        productNameLabel.text = model.name
        productDescriptionLabel.text = model.description
        productImageView.image = model.image ?? .shoppingBasket
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productNameLabel.text = ""
        productImageView.image = nil
        productDescriptionLabel.text = ""
    }
    
    private func setupUI() {
        productImageView.contentMode = .scaleAspectFit
        
        productNameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        
        productDescriptionLabel.numberOfLines = 0
        productDescriptionLabel.font = .systemFont(ofSize: 13, weight: .regular)
        productDescriptionLabel.textColor = .lightGray
        
        addProductToBasketButton.layer.borderWidth = 1
        addProductToBasketButton.layer.borderColor = UIColor.systemPink.cgColor
        addProductToBasketButton.layer.cornerRadius = 6
        addProductToBasketButton.setTitleColor(.systemPink, for: .normal)
    }
    
    private func addSubviews() {
        for subview in [productImageView, productNameLabel, productDescriptionLabel, addProductToBasketButton] {
            contentView.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 16),
            productImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: 16),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productImageView.trailingAnchor.constraint(equalTo: productNameLabel.leadingAnchor, constant: -16),
            productImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 144),
            
            productNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            productNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 180),
            productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            productDescriptionLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 8),
            productDescriptionLabel.bottomAnchor.constraint(equalTo: addProductToBasketButton.topAnchor, constant: -16),
            productDescriptionLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            productDescriptionLabel.trailingAnchor.constraint(equalTo: productNameLabel.trailingAnchor),
            
            addProductToBasketButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),
            addProductToBasketButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            addProductToBasketButton.widthAnchor.constraint(equalToConstant: 87),
            addProductToBasketButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
}
