//
//  Service.swift
//  Flowers
//
//  Created by Ani Eduard on 12/02/2020.
//  Copyright © 2020 Ani Eduard. All rights reserved.
//

import Foundation

protocol Service: AnyObject {
    init(networkClient: NetworkClient)
}
