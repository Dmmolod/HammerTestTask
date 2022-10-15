//
//  CategoryButton.swift
//  HammerTestTask
//
//  Created by Дмитрий Молодецкий on 15.10.2022.
//

import UIKit

class CategoryButton: UIButton {
    
    let category: ProductCategory
    
    init(category: ProductCategory) {
        self.category = category
        super.init(frame: .zero)
    }
    required init?(coder: NSCoder) { nil }
    
    override var isSelected: Bool {
        didSet {
            layer.borderWidth = isSelected ? 0 : 1
            backgroundColor = isSelected ? .systemPink.withAlphaComponent(0.3) : .clear
            titleLabel?.font = isSelected ? .systemFont(ofSize: 13, weight: .bold) : .systemFont(ofSize: 13, weight: .regular)
        }
    }
}
