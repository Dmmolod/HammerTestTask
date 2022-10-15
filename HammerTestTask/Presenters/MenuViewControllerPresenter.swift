//
//  MenuViewControllerPresenter.swift
//  HammerTestTask
//
//  Created by Дмитрий Молодецкий on 15.10.2022.
//

import Foundation

protocol MenuViewControllerPresenterDelegate: AnyObject {
    func scrollToRow(_ row: Int)
    func selectCategory(_ category: ProductCategory)
    func modelDidUpdate()
}

class MenuViewControllerPresenter {
    
    weak var delegate: MenuViewControllerPresenterDelegate?
    
    var dataSource = [Product]()
    var categoryDataSource = [CategoryModel]()
    
    func fetchProducts() {
        ProductMock.getProducts { [weak self] products in
            self?.dataSource = products
            
            self?.categoryDataSource = []
            
            for product in products {
                if self?.categoryDataSource.contains(where: { $0.category == product.category}) == true {
                    continue
                } else {
                    self?.categoryDataSource.append(CategoryModel(category: product.category))
                }
            }
            
            self?.delegate?.modelDidUpdate()
        }
    }
    
    func productFor(_ row: Int) -> Product? {
        guard dataSource.count > row else { return nil }
        return dataSource[row]
    }
    
    func categoryDidSelect(_ category: ProductCategory) {
        guard let row = dataSource.firstIndex(where: { $0.category == category }) else { return }
        delegate?.scrollToRow(row)
    }
    
    func didChangeCurrentVisibleRow(_ row: Int) {
        guard dataSource.count > row else { return }
        let newCategory = dataSource[row].category
        delegate?.selectCategory(newCategory)
    }
}
