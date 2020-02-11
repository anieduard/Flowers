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
    
}

protocol OrdersViewModel: AnyObject {
    
}

final class OrdersViewModelImpl: OrdersViewModel {
    
    typealias DataSourceType = NSDiffableDataSourceSnapshot<Section, UIImage?>
    
    // MARK: - Public properties
    
    weak var flowDelegate: OrdersFlowDelegate?
    
    // MARK: - Private properties
    
    private var dataSourceSnapshot: DataSourceType
    
    // MARK: - Init
    
    init() {
        dataSourceSnapshot = DataSourceType()
        dataSourceSnapshot.appendSections(Section.allCases)
    }
}

// MARK: - Section

extension OrdersViewModelImpl {
    
    enum Section: CaseIterable {
        case orders
    }
}
