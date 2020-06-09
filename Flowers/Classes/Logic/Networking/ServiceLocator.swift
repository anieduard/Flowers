//
//  ServiceLocator.swift
//  Flowers
//
//  Created by Ani Eduard on 12/02/2020.
//  Copyright © 2020 Ani Eduard. All rights reserved.
//

import Foundation

class ServiceLocator {
    
    private var container: [String: AnyObject] = [:]
    
    // MARK: - Network client
    
    private let networkClient: NetworkClient
    
    public init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    // MARK: - Services
    
    func resolve<S: Service>(type: S.Type) -> S {
        let key = String(describing: type)
        
        if let service = container[key] as? S {
            return service
        }
        
        let service = S(networkClient: networkClient)
        container[key] = service
        return service
    }
    
    func resetAll() {
        container = [:]
    }
}
