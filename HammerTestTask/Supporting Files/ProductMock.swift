//
//  ProductMock.swift
//  HammerTestTask
//
//  Created by Дмитрий Молодецкий on 15.10.2022.
//

import Foundation

struct ProductMock {
    
    static func getProducts(completion: @escaping ([Product]) -> Void) {
        DispatchQueue.main.async {
            
            let products: [Product] = [
                Product(category: .pizza, name: "Ветчина и грибы", description: "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус", image: .pizzaHM),
                Product(category: .pizza, name: "Баварские колбаски", description: "Баварски колбаски,ветчина, пикантная пепперони, острая чоризо, моцарелла, томатный соус", image: .pizzaBV),
                Product(category: .pizza, name: "Нежный лосось", description: "Лосось, томаты черри, моцарелла, соус песто", image: .pizzaFish),
                Product(category: .pizza, name: "Пицца четыре сыра", description: "Соус Карбонара, Сыр Моцарелла, Сыр Пармезан, Сыр Роккфорти, Сыр Чеддер (тёртый)", image: .pizza4cheeses),
                
                Product(category: .drinks, name: "Pepsi", description: "Pepsi, 0,33", image: .pepsi),
                Product(category: .drinks, name: "Coca-cola", description: "Coca-cola, 0,33", image: .cola),
                Product(category: .drinks, name: "Sprite", description: "Sprite, 0,33", image: .sprite),
                
                Product(category: .combo, name: "Combo number 1", description: "BIIIG COMBO", image: .bigCombo),
                Product(category: .combo, name: "Combo number 2", description: "Medium combo, 1kg", image: .mediumCombo),
                
                Product(category: .desserts, name: "Вишневый торт", description: "Вишня и много других вкусных ингридиентов", image: .cheryCake),
                Product(category: .desserts, name: "Медовик", description: "Очень сытный и вкусный торт \"Медовик\"", image: .honey),
                Product(category: .desserts, name: "Круасан", description: "МММ, французская вкуснятина", image: .croissant),
            ]
            
            completion(products)
        }
    }
    
}
