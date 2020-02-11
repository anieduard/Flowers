//
//  OrderCollectionViewCell.swift
//  Flowers
//
//  Created by Ani Eduard on 11/02/2020.
//  Copyright © 2020 Ani Eduard. All rights reserved.
//

import UIKit
import Kingfisher

final class OrderCollectionViewCell: UICollectionViewCell, NibReusable {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    
    // MARK: - Public properties
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: .normalAnimationDuration) {
                self.transform = self.isHighlighted ? .scale : .identity
            }
        }
    }
    
    var viewModel: OrderCollectionViewCellViewModel? {
        didSet {
            imageView.kf.setImage(with: viewModel?.imageURL)
            nameLabel.text = viewModel?.name
            addressLabel.text = viewModel?.address
        }
    }
    
    // MARK: - UI
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = .cornerRadius
        layer.shadowOpacity = 0.5
        
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = .bigCornerRadius
    }
}

// MARK: - Constants

private extension CGAffineTransform {
    static let scale = CGAffineTransform(scaleX: 0.95, y: 0.95)
}
