//
//  OrdersViewModel.swift
//  Flowers
//
//  Created by Ani Eduard on 11/02/2020.
//  Copyright © 2020 Ani Eduard. All rights reserved.
//

import Foundation
import class UIKit.UIImage
import struct UIKit.NSDiffableDataSourceSnapshot

protocol OrdersFlowDelegate: AnyObject {
    func shouldShowError(_ error: Error, on viewModel: OrdersViewModel)
    func shouldShowOrderDetail(for order: Order, on viewModel: OrdersViewModel)
}

protocol OrdersViewModel: AnyObject {
    var stateDidChange: ((OrdersViewModelImpl.State<OrdersViewModelImpl.DataSourceType>) -> Void)? { get set }
    
    func loadData()
    func didSelectItem(at indexPath: IndexPath)
}

final class OrdersViewModelImpl: OrdersViewModel {
    
    typealias DataSourceType = NSDiffableDataSourceSnapshot<Section, OrderCollectionViewCellViewModelImpl>
    
    enum State<T> {
        case loading
        case content(T)
    }
    
    // MARK: - Public properties
    
    weak var flowDelegate: OrdersFlowDelegate?
    
    var stateDidChange: ((State<DataSourceType>) -> Void)?
    
    // MARK: - Private properties
    
    private let ordersService: OrdersService
    
    private var orders: [Order] = []
    
    private var dataSourceSnapshot: DataSourceType
    
    // MARK: - Init
    
    init(serviceLocator: ServiceLocator) {
        self.ordersService = serviceLocator.resolve(type: OrdersServiceImpl.self)
        
        dataSourceSnapshot = DataSourceType()
        dataSourceSnapshot.appendSections(Section.allCases)
    }
    
    // MARK: - Logic
    
    func loadData() {
        stateDidChange?(.loading)
        
        ordersService.fetchOrders { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let orders):
                self.orders = orders
                self.dataSourceSnapshot.appendItems(orders.map(OrderCollectionViewCellViewModelImpl.init), toSection: .orders)
                self.stateDidChange?(.content(self.dataSourceSnapshot))
            case .failure(let error):
                self.flowDelegate?.shouldShowError(error, on: self)
            }
        }
    }
    
    // MARK: - User interaction
    
    func didSelectItem(at indexPath: IndexPath) {
        let order = orders[indexPath.item]
        flowDelegate?.shouldShowOrderDetail(for: order, on: self)
    }
}

// MARK: - Section

extension OrdersViewModelImpl {
    
    enum Section: CaseIterable {
        case orders
    }
}
