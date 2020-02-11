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
    private weak var alertController: UIAlertController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        #warning("DI?")
        let viewModel = OrdersViewModelImpl(ordersService: .init())
        viewModel.flowDelegate = self
        let viewController = OrdersViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: true)
    }
}

// MARK: - OrdersFlowDelegate

extension OrdersCoordinator: OrdersFlowDelegate {
    
    func shouldShowError(_ error: Error, on viewModel: OrdersViewModel) {
        guard alertController == nil else { return }
        
        let actions: [UIAlertAction] = [UIAlertAction(title: .retry, style: .default, handler: { _ in viewModel.loadData() })]
        let alertController = showErrorAlertController(on: navigationController, error: error, actions: actions)
        self.alertController = alertController
    }
}

// MARK: - Constants

private extension String {
    static let retry = "Retry"
}
