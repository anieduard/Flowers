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
    private let serviceLocator: ServiceLocator
    private weak var alertController: UIAlertController?
    
    init(navigationController: UINavigationController, serviceLocator: ServiceLocator) {
        self.navigationController = navigationController
        self.serviceLocator = serviceLocator
    }
    
    func start() {
        let viewModel = OrdersViewModelImpl(serviceLocator: serviceLocator)
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
    
    func shouldShowOrderDetail(for order: Order, on viewModel: OrdersViewModel) {
        let storyboard = UIStoryboard(name: String(describing: OrderDetailViewController.self), bundle: .main)
        let viewModel = OrderDetailViewModelImpl(order: order)
        guard let viewController = storyboard.instantiateInitialViewController(creator: { coder in
            return OrderDetailViewController(coder: coder, viewModel: viewModel)
        }) else {
            fatalError("Failed to load OrderDetailViewController from storyboard.")
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - Constants

private extension String {
    static let retry = "Retry"
}
