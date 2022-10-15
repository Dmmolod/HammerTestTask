//
//  CityButton.swift
//  HammerTestTask
//
//  Created by Дмитрий Молодецкий on 14.10.2022.
//

import UIKit

class CityButton: UIButton {
    
    var cityName: String? {
        get { cityLabel.text }
        set { cityLabel.text = newValue }
    }
    private let cityLabel = UILabel()
    private let arrow = UIImageView(image: .arrowDown)
    
    init(currentCityName: String? = nil) {
        super.init(frame: .zero)
        
        cityLabel.text = currentCityName ?? "Выберите город"
        cityLabel.font = .systemFont(ofSize: 20, weight: .regular)
        
        addSubviews()
        applyConstraints()
    }
    required init?(coder: NSCoder) { nil }

    private func addSubviews() {
        addSubview(cityLabel)
        addSubview(arrow)
    }
    private func applyConstraints() {
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        arrow.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: topAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            cityLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            arrow.centerYAnchor.constraint(equalTo: cityLabel.centerYAnchor),
            arrow.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor, constant: 10),
            arrow.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
