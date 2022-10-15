//
//  BannerView.swift
//  HammerTestTask
//
//  Created by Дмитрий Молодецкий on 14.10.2022.
//

import UIKit

class BannerView: UIView {
    
    private(set) lazy var contentSize = CGSize()
    var images: [UIImage?] {
        get { imageViews.map { $0.image } }
        set {
            imageViews = newValue.map { UIImageView(image: $0) }
            setupStackView()
        }
    }
    
    override var frame: CGRect {
        get { super.frame }
        set {
            super.frame = newValue
            setupStackView()
        }
    }
    
    private var imageViews = [UIImageView]()
    private var stackView = UIStackView()
    private var itemWidth: CGFloat = 0
    
    init(itemWidth: CGFloat) {
        self.itemWidth = itemWidth
        super.init(frame: .zero)
    }
    required init?(coder: NSCoder) { nil }
    
    private func setupStackView() {
        
        stackView.removeFromSuperview()
        
        stackView = UIStackView(arrangedSubviews: imageViews)
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
        stackView.frame = frame
        stackView.frame.size.width = itemWidth * CGFloat(imageViews.count)
        stackView.frame.origin.x = frame.origin.x + 16
        
        imageViews.forEach { imageView in
            imageView.layer.cornerRadius = frame.height/10
            imageView.clipsToBounds = true
        }
        addSubview(stackView)
        contentSize = CGSize(width: stackView.frame.width + 32, height: stackView.frame.height)
    }
}
