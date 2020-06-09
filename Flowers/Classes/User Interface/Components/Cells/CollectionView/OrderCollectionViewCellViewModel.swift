//
//  OrderCollectionViewCellViewModel.swift
//  Flowers
//
//  Created by Ani Eduard on 11/02/2020.
//  Copyright © 2020 Ani Eduard. All rights reserved.
//

import Foundation

protocol OrderCollectionViewCellViewModel: AnyObject {
    var imageURL: URL { get }
    var name: String { get }
    var address: String { get }
}

final class OrderCollectionViewCellViewModelImpl: OrderCollectionViewCellViewModel {
    
    // MARK: - Public properties
    
    let imageURL: URL
    let name: String
    let address: String
    
    // MARK: - Private properties
    
    private let order: Order
    
    // MARK: - Init
    
    init(order: Order) {
        self.order = order
        
        imageURL = order.image
        name = order.deliverTo
        address = order.deliveryAddress
    }
}

// MARK: - Hashable

extension OrderCollectionViewCellViewModelImpl: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(order)
    }
    
    static func == (lhs: OrderCollectionViewCellViewModelImpl, rhs: OrderCollectionViewCellViewModelImpl) -> Bool {
        return lhs.order == rhs.order
    }
}
