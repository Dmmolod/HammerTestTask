//
//  MenuViewController.swift
//  HammerTestTask
//
//  Created by Дмитрий Молодецкий on 13.10.2022.
//

import UIKit

class MenuViewController: UIViewController {
    
    var presenter: MenuViewControllerPresenter?
    
    private let bannersScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private var categoryScrollView: CategoryScrollView?
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
        return tableView
    }()
    private let cityButton = CityButton(currentCityName: "Москва")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        view.addSubview(cityButton)
        view.addSubview(tableView)
        
        applyConstraints()
        
        presenter?.delegate = self
        presenter?.fetchProducts()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = bannersScrollView
    }
    
    private func applyConstraints() {
        cityButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cityButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: cityButton.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setCorners(_ cell: UITableViewCell, for indexPath: IndexPath) {
        if indexPath.row == 0 && indexPath.section == 0 {
            cell.layer.cornerRadius = 20
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else { cell.layer.cornerRadius = 0; cell.layer.maskedCorners = [] }
    }
    
    func changedTopRow() {
        guard let topRow = tableView.indexPathsForVisibleRows?[0].row else { return }
        presenter?.didChangeCurrentVisibleRow(topRow + 1)
    }
}

extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.dataSource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier,
                                                       for: indexPath) as? ProductTableViewCell,
              let product = presenter?.productFor(indexPath.row) else { return UITableViewCell() }
        
        setCorners(cell, for: indexPath)
        
        cell.configure(product)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        bannersScrollView.frame.size.height = 150
        
        let banner = BannerView(itemWidth: 300)
        banner.images = [.banner1, .banner2, .banner3]
        bannersScrollView.addSubview(banner)
        
        banner.frame = bannersScrollView.bounds
        bannersScrollView.contentSize = banner.contentSize
        
        guard let categoryDataSource = presenter?.categoryDataSource else { return nil }
        let header = CategoryScrollView(categoryModels: categoryDataSource,
                                                itemSize: CGSize(width: view.bounds.width/3.5, height: 32))
        header.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        header.categoryDelegate = self
        
        categoryScrollView = header
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        45
    }
}

extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        changedTopRow()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        changedTopRow()
    }
}

extension MenuViewController: CategoryScrollViewDelegate {
    func didSelect(_ category: ProductCategory) {
        presenter?.categoryDidSelect(category)
    }
}

extension MenuViewController: MenuViewControllerPresenterDelegate {
    
    func scrollToRow(_ row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func modelDidUpdate() {
        tableView.reloadData()
    }
    
    func selectCategory(_ category: ProductCategory) {
        categoryScrollView?.selectCategory(category)
    }
}
