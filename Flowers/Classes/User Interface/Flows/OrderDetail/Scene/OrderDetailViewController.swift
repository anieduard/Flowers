//
//  OrderDetailViewController.swift
//  Flowers
//
//  Created by Ani Eduard on 12/02/2020.
//  Copyright © 2020 Ani Eduard. All rights reserved.
//

import UIKit

final class OrderDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBOutlet private weak var imageContainerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    @IBOutlet private weak var deliveryInformationContainerView: UIView!
    
    @IBOutlet private weak var receiverNameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var receiverPhoneLabel: UILabel!
    
    // MARK: - Private properties
    
    private let viewModel: OrderDetailViewModel
    
    // MARK: - Init
    
    init?(coder: NSCoder, viewModel: OrderDetailViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        // This is needed because contentInsetAdjustmentBehavior is set to .automatic and we need the imageView to be behind the transparent navigation bar.
        scrollView.contentInset.top = -view.safeAreaInsets.top
        scrollView.verticalScrollIndicatorInsets.top = -view.safeAreaInsets.top
    }
    
    private func initView() {
        scrollView.delegate = self
        
        imageContainerView.layer.masksToBounds = true
        imageContainerView.layer.cornerRadius = .bigCornerRadius
        imageContainerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        deliveryInformationContainerView.layer.masksToBounds = true
        deliveryInformationContainerView.layer.cornerRadius = .bigCornerRadius
        
        deliveryInformationContainerView.layer.masksToBounds = false
        deliveryInformationContainerView.layer.shadowColor = UIColor.black.cgColor
        deliveryInformationContainerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        deliveryInformationContainerView.layer.shadowRadius = .cornerRadius
        deliveryInformationContainerView.layer.shadowOpacity = 0.25
    }
    
    // MARK: - Bindings
    
    private func initBindings() {
        imageView.kf.setImage(with: viewModel.imageURL)
        descriptionLabel.text = viewModel.description
        priceLabel.text = viewModel.price
        receiverNameLabel.text = viewModel.receiverName
        dateLabel.text = viewModel.date
        addressLabel.text = viewModel.address
        receiverPhoneLabel.text = viewModel.receiverPhone
    }
}

// MARK: - UIScrollViewDelegate

extension OrderDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            let offsetHeightRatio = -scrollView.contentOffset.y / imageContainerView.frame.height
            let scaleFactor = 1 + offsetHeightRatio
            imageContainerView.transform = CGAffineTransform(translationX: 0, y: scrollView.contentOffset.y + (offsetHeightRatio * imageContainerView.frame.height) / 2).concatenating(CGAffineTransform(scaleX: scaleFactor, y: scaleFactor))
        } else {
            imageContainerView.transform = CGAffineTransform(translationX: 0, y: scrollView.contentOffset.y * 0.25)
        }
    }
}
