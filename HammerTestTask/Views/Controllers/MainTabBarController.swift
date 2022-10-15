//
//  MainTabBarController.swift
//  HammerTestTask
//
//  Created by Дмитрий Молодецкий on 13.10.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuVCPresenter = MenuViewControllerPresenter()
        
        let menuVC = MenuViewController()
        let contactsVC = ContactsViewController()
        let profileVC = ProfileViewController()
        let shoppingBasketVC = ShoppingBasketViewControllers()
        
        menuVC.presenter = menuVCPresenter
        
        menuVC.title = "Меню"
        contactsVC.title = "Контакты"
        profileVC.title = "Профиль"
        shoppingBasketVC.title = "Корзина"
        
        menuVC.tabBarItem.image = .menu
        contactsVC.tabBarItem.image = .contacts
        profileVC.tabBarItem.image = .profile
        shoppingBasketVC.tabBarItem.image = .shoppingBasket
        
        tabBar.tintColor = .systemPink
        tabBar.backgroundColor = .white
        
        setViewControllers([menuVC, contactsVC, profileVC, shoppingBasketVC], animated: false)
    }
    
}
