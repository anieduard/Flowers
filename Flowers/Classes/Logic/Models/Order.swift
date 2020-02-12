//
//  Order.swift
//  Flowers
//
//  Created by Ani Eduard on 11/02/2020.
//  Copyright © 2020 Ani Eduard. All rights reserved.
//

import Foundation

struct Order: Decodable, Hashable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case image
        case description
        case price
        case date
        case deliverTo = "deliver_to"
        case deliveryAddress = "delivery_address"
        case receiverPhone = "receiver_phone"
    }
    
    private let id: Int
    
    let image: URL
    let description: String
    let price: Double
    let date: Date
    let deliverTo: String
    let deliveryAddress: String
    let receiverPhone: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        image = try container.decode(URL.self, forKey: .image)
        description = try container.decode(String.self, forKey: .description)
        price = try container.decode(Double.self, forKey: .price)
        date = try container.decode(Date.self, forKey: .date)
        deliverTo = try container.decode(String.self, forKey: .deliverTo)
        deliveryAddress = try container.decode(String.self, forKey: .deliveryAddress)
        receiverPhone = try container.decode(String.self, forKey: .receiverPhone)
    }
}
