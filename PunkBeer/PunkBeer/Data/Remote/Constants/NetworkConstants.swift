//
//  NetworkConstants.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import UIKit
internal struct NetworkConstants {
    
    struct Network {
        enum HTTPHeaderField: String {
            case authentication = "Authorization"
            case contentType = "Content-Type"
            case acceptType = "Accept"
            case acceptEncoding = "Accept-Encoding"
        }
        
        enum ContentType {
            case json
        
            
            var rawValue: String {
                switch self {
                case .json:
                    return "application/json"
                }
            }
        }
        
        struct URLs {
            static var base: URL {
                guard let url = URL(string: "https://api.punkapi.com/v2/") else {
                    fatalError("Error to create url")
                }
                return url
            }
        }
    }
}
