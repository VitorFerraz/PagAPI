//
//  Beer.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Foundation
struct Beer: ModelInterface {
    var id: Int?
    var name: String?
    var image: String?
    var abv: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image = "image_url"
        case abv
    }
}

