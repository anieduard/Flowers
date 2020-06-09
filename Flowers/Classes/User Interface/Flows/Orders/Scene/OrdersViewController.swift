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
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<OrdersViewModelImpl.Section, OrderCollectionViewCellViewModelImpl> = {
        UICollectionViewDiffableDataSource<OrdersViewModelImpl.Section, OrderCollectionViewCellViewModelImpl>(collectionView: collectionView) { collectionView, indexPath, viewModel in
            let cell: OrderCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.viewModel = viewModel
            return cell
        }
    }()
    
    private let activityIndicatorView = UIActivityIndicatorView(style: .medium)
    
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
        
        viewModel.loadData()
    }
    
    private func initView() {
        navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "ic_back.pdf")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "ic_back.pdf")
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationItem.title = .orders
        
        view.backgroundColor = .systemBackground
        
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        collectionView.contentInset.top = .padding3x
        collectionView.backgroundView = activityIndicatorView
        collectionView.register(cellType: OrderCollectionViewCell.self)
        
        collectionViewFlowLayout.minimumLineSpacing = .padding3x
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let itemSizeWidth = view.frame.width - (view.safeAreaInsets.left + view.safeAreaInsets.right) - 2 * .padding3x
        collectionViewFlowLayout.itemSize = CGSize(width: itemSizeWidth, height: itemSizeWidth / 2)
    }
    
    // MARK: - Bindings
    
    private func initBindings() {
        viewModel.stateDidChange = { [weak self] state in
            switch state {
            case .loading:
                self?.activityIndicatorView.startAnimating()
            case .content(let dataSourceSnapshot):
                self?.activityIndicatorView.stopAnimating()
                self?.dataSource.apply(dataSourceSnapshot, animatingDifferences: true)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate

extension OrdersViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0

        UIView.animate(withDuration: .normalAnimationDuration, delay: 0.05 * TimeInterval(indexPath.row), animations: {
            cell.alpha = 1
        })
    }
}

// MARK: - Constants

private extension String {
    static let orders = "Orders"
}
