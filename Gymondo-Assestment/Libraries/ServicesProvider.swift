//
//  ServicesProvider.swift
//  Gif
//
//  Created by Erfan Andesta on 09/05/2022.
//  Copyright © 2022 Erfan Andesta. All rights reserved.
//

import Foundation

class ServicesProvider {
    let network: NetworkServiceType

    static func defaultProvider() -> ServicesProvider {
        let network = NetworkService()
        return ServicesProvider(network: network)
    }

    init(network: NetworkServiceType) {
        self.network = network
    }
}
