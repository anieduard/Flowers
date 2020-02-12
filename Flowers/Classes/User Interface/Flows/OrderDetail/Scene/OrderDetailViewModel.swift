//
//  OrderDetailViewModel.swift
//  Flowers
//
//  Created by Ani Eduard on 12/02/2020.
//  Copyright © 2020 Ani Eduard. All rights reserved.
//

import Foundation

protocol OrderDetailViewModel: AnyObject {
    var imageURL: URL { get }
    var description: String { get }
    var price: String? { get }
    var receiverName: String { get }
    var date: String { get }
    var address: String { get }
    var receiverPhone: String { get }
}

final class OrderDetailViewModelImpl: OrderDetailViewModel {
    
    // MARK: - Public properties
    
    let imageURL: URL
    let description: String
    let price: String?
    let receiverName: String
    let date: String
    let address: String
    let receiverPhone: String
    
    // MARK: - Init
    
    init(order: Order) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        imageURL = order.image
        description = order.description.uppercased()
        price = numberFormatter.string(from: NSNumber(value: order.price))
        receiverName = order.deliverTo
        date = dateFormatter.string(from: order.date)
        address = order.deliveryAddress
        receiverPhone = order.receiverPhone
    }
}
