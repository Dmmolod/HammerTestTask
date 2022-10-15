//
//  ProductCategory.swift
//  HammerTestTask
//
//  Created by Дмитрий Молодецкий on 15.10.2022.
//

import Foundation

enum ProductCategory {
    case pizza, combo, desserts, drinks
    
    var categoryName: String {
        switch self {
        case .pizza: return "Пицца"
        case .combo: return "Комбо"
        case .desserts: return "Десерты"
        case .drinks: return "Напитки"
        }
    }
}
