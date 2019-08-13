//
//  GenericPageList.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Foundation
struct GenericList<T: Decodable>: Decodable {
    var limit: Int?
    var page: Int?
    var result: [T]?
    var totalElements: Int?
    var totalPages: Int?
}
