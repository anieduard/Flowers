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
}

protocol OrdersViewModel: AnyObject {
    var reloadData: ((OrdersViewModelImpl.DataSourceType) -> Void)? { get set }
    
    func loadData()
}

final class OrdersViewModelImpl: OrdersViewModel {
    
    typealias DataSourceType = NSDiffableDataSourceSnapshot<Section, OrderCollectionViewCellViewModelImpl>
    
    // MARK: - Public properties
    
    weak var flowDelegate: OrdersFlowDelegate?
    
    var reloadData: ((DataSourceType) -> Void)?
    
    // MARK: - Private properties
    
    private let ordersService: OrdersService
    private var dataSourceSnapshot: DataSourceType
    
    // MARK: - Init
    
    init(ordersService: OrdersService) {
        self.ordersService = ordersService
        
        dataSourceSnapshot = DataSourceType()
        dataSourceSnapshot.appendSections(Section.allCases)
    }
    
    // MARK: - Logic
    
    func loadData() {
        ordersService.fetchOrders { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let orders):
                self.dataSourceSnapshot.appendItems(orders.map(OrderCollectionViewCellViewModelImpl.init), toSection: .orders)
                self.reloadData?(self.dataSourceSnapshot)
            case .failure(let error):
                self.flowDelegate?.shouldShowError(error, on: self)
            }
        }
    }
}

// MARK: - Section

extension OrdersViewModelImpl {
    
    enum Section: CaseIterable {
        case orders
    }
}
