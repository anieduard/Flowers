//
//  Coordinator.swift
//  Flowers
//
//  Created by Ani Eduard on 11/02/2020.
//  Copyright © 2020 Ani Eduard. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get }
    
    func start()
}

extension Coordinator {
    
    @discardableResult
    func showAlertController(on viewController: UIViewController, title: String?, message: String?, actions: [UIAlertAction] = [.ok]) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach(alertController.addAction)
        viewController.present(alertController, animated: true)
        
        return alertController
    }
    
    @discardableResult
    func showErrorAlertController(on viewController: UIViewController, error: Error, actions: [UIAlertAction]) -> UIAlertController {
        let alertController = UIAlertController(title: .oups, message: error.localizedDescription, preferredStyle: .alert)
        actions.forEach(alertController.addAction)
        viewController.present(alertController, animated: true)
        
        return alertController
    }
}

// MARK: - Constants

private extension String {
    static let oups = "Oups.."
}

private extension UIAlertAction {
    static let ok = UIAlertAction(title: "Ok", style: .default)
}
