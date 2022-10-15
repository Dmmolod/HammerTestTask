//
//  CategoryScrollView.swift
//  HammerTestTask
//
//  Created by Дмитрий Молодецкий on 14.10.2022.
//

import UIKit

protocol CategoryScrollViewDelegate: AnyObject {
    func didSelect(_ category: ProductCategory)
}

class CategoryScrollView: UIScrollView {
    
    weak var categoryDelegate: CategoryScrollViewDelegate?
    
    private(set) var categoryModels: [CategoryModel]
    private var stackView = UIStackView()
    private var stackViewWidthConstraint = NSLayoutConstraint()
    private var stackViewHeightConstraint = NSLayoutConstraint()
    private var categoryButtons = [CategoryButton]()
    private var selectedCategory = UIButton()
    private var itemSize: CGSize
    
    init(categoryModels: [CategoryModel], itemSize: CGSize = CGSize()) {
        self.categoryModels = categoryModels
        self.itemSize = itemSize
        super.init(frame: .zero)
        setupUI()
        applyConstraints()
    }
    required init?(coder: NSCoder) { nil }
    
    func selectCategory(_ category: ProductCategory) {
        guard let categoryButton = categoryButtons.first(where: { $0.category == category }) else { return }
        selectedCategory.isSelected = false
        categoryButton.isSelected = true
        selectedCategory = categoryButton
        
        scrollToSelectedCategory()
    }
    
    private func scrollToSelectedCategory() {
        let newRect = CGRect(x: selectedCategory.frame.origin.x,
                             y: selectedCategory.frame.origin.y,
                             width: selectedCategory.frame.width,
                             height: selectedCategory.frame.height)
        
        scrollRectToVisible(newRect, animated: true)
    }
    
    private func setupUI() {
        categoryButtons = categoryModels.enumerated().map {
            let button = CategoryButton(category: $1.category)
            button.setTitle($1.category.categoryName, for: .normal)
            button.layer.cornerRadius = itemSize.height/2
            button.layer.borderColor = UIColor.systemPink.cgColor
            button.layer.borderWidth = 1
            button.setTitleColor(.systemPink, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
            button.addTarget(self, action: #selector(categorySelected), for: .touchUpInside)
            if $0 == 0 {
                selectedCategory = button
                button.isSelected = true
            }
            return button
        }
        
        stackView = UIStackView(arrangedSubviews: categoryButtons)
    
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        addSubview(stackView)
        contentSize = CGSize(width: itemSize.width * CGFloat(categoryModels.count),
                             height: itemSize.height)
    }
    
    private func applyConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        stackViewWidthConstraint = stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: itemSize.width * CGFloat(categoryModels.count) - 32)
        stackViewHeightConstraint = stackView.heightAnchor.constraint(equalToConstant: itemSize.height)
        
        stackViewWidthConstraint.isActive = true
        stackViewHeightConstraint.isActive = true
    }
    
    @objc private func categorySelected(_ button: UIButton) {
        guard let categoryButton = button as? CategoryButton else { return }
        
        categoryDelegate?.didSelect(categoryButton.category)
        selectedCategory.isSelected = false
        categoryButton.isSelected = true
        selectedCategory = categoryButton
        
        scrollToSelectedCategory()
    }
}
