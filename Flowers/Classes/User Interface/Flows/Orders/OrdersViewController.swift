//
//  OrdersViewController.swift
//  Flowers
//
//  Created by Ani Eduard on 11/02/2020.
//  Copyright © 2020 Ani Eduard. All rights reserved.
//

import UIKit

final class OrdersViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let viewModel: OrdersViewModel
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        return collectionView
    }()
    private let collectionViewFlowLayout = UICollectionViewFlowLayout()
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<OrdersViewModelImpl.Section, UIImage?> = {
        UICollectionViewDiffableDataSource<OrdersViewModelImpl.Section, UIImage?>(collectionView: collectionView) { collectionView, indexPath, image in
            let cell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }()
    
    // MARK: - Init
    
    init(viewModel: OrdersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    override func loadView() {
        view = collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initBindings()
    }
    
    private func initView() {
        collectionView.dataSource = dataSource
        collectionView.register(cellType: UICollectionViewCell.self)
    }
    
    // MARK: - Bindings
    
    private func initBindings() {
        
    }
    
    // MARK: - User interaction
    
}

// MARK: - Constants
