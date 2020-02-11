//
//  OrdersCoordinator.swift
//  Flowers
//
//  Created by Ani Eduard on 11/02/2020.
//  Copyright © 2020 Ani Eduard. All rights reserved.
//

import UIKit

final class OrdersCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = OrdersViewModelImpl()
        viewModel.flowDelegate = self
        let viewController = OrdersViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: true)
    }
}

// MARK: - OrdersFlowDelegate

extension OrdersCoordinator: OrdersFlowDelegate {
    
}
