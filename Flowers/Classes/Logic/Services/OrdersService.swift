//
//  OrdersService.swift
//  Flowers
//
//  Created by Ani Eduard on 11/02/2020.
//  Copyright © 2020 Ani Eduard. All rights reserved.
//

import Foundation

protocol OrdersService: Service {
    func fetchOrders(completion: @escaping (Result<[Order], Error>) -> Void)
}

final class OrdersServiceImpl: OrdersService {
    
    // MARK: - Public properties
    
    let networkClient: NetworkClient
    
    var path: String { return APIConstants.Path.orders }
    
    // MARK: - Init
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    // MARK: - Logic
    
    func fetchOrders(completion: @escaping (Result<[Order], Error>) -> Void) {
        let request = URLRequest(url: url)
        networkClient.performRequest(request, completion: completion)
    }
}
