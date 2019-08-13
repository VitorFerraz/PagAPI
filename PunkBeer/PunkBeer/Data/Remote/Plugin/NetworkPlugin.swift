//
//  NetworkPlugin.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Moya
enum NetworkPlugin {
    /// Used to enable logging network calls
    case log
    
    var plugin: PluginType {
        switch self {
        case .log:
            return NetworkLoggerPlugin(verbose: true,
                                       cURL: true,
                                       output: nil,
                                       requestDataFormatter: nil,
                                       responseDataFormatter: nil)
        }
    }
}
