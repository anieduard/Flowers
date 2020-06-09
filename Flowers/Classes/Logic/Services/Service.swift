//
//  Service.swift
//  Flowers
//
//  Created by Ani Eduard on 12/02/2020.
//  Copyright © 2020 Ani Eduard. All rights reserved.
//

import Foundation

protocol Service: AnyObject {
    var networkClient: NetworkClient { get }
    var path: String { get }
    
    init(networkClient: NetworkClient)
}

extension Service {
    
    var url: URL {
        var components = networkClient.baseURL
        components.path = path
        guard let url = components.url else { fatalError("The URL couldn't be formed from the specified components: \(components).") }
        return url
    }
}
