//
//  RootCoordinator.swift
//  Flowers
//
//  Created by Ani Eduard on 11/02/2020.
//  Copyright © 2020 Ani Eduard. All rights reserved.
//

import UIKit

final class RootCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let serviceLocator: ServiceLocator
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.serviceLocator = ServiceLocator(networkClient: NetworkClient())
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let ordersCoordinator = OrdersCoordinator(navigationController: navigationController, serviceLocator: serviceLocator)
        ordersCoordinator.start()
        childCoordinators.append(ordersCoordinator)
    }
}
