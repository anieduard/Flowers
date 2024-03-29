//
//  UIView+Nib.swift
//  Flowers
//
//  Created by Ani Eduard on 11/02/2020.
//  Copyright © 2020 Ani Eduard. All rights reserved.
//

import UIKit

protocol NibRepresentable: AnyObject {
    static var nib: UINib { get }
}

extension NibRepresentable where Self: UIView {
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    static func instantiate<T: UIView>(withOwner ownerOrNil: Any? = nil, options optionsOrNil: [UINib.OptionsKey: Any]? = nil) -> T {
        guard let view = nib.instantiate(withOwner: ownerOrNil, options: optionsOrNil).first as? T else {
            fatalError("The nib \(nib) expected its type to be \(self).")
        }
        return view
    }
}

/// A protocol used to register / dequeue reusable Nib represented views in code.
///
/// This is needed as a separate protocol in order to use Nib represented views in classes that are also reusable.
protocol NibReusable: NibRepresentable { }
