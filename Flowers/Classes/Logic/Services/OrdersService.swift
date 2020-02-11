//
//  OrdersService.swift
//  Flowers
//
//  Created by Ani Eduard on 11/02/2020.
//  Copyright © 2020 Ani Eduard. All rights reserved.
//

import Foundation

final class OrdersService {
    
    // MARK: - Private properties
    
    private let networkClient: NetworkClient
    
    private var url: URL {
        var components = networkClient.baseURL
        components.path = APIConstants.Path.orders
        guard let url = components.url else { fatalError("The URL couldn't be formed from the specified components: \(components).") }
        return url
    }
    
    // MARK: - Init
    
    init(networkClient: NetworkClient = .init()) {
        self.networkClient = networkClient
    }
    
    // MARK: - Logic
    
    func fetchOrders(completion: @escaping (Result<[Order], Error>) -> Void) {
        let request = URLRequest(url: url)
        networkClient.performRequest(request, completion: completion)
    }
}
