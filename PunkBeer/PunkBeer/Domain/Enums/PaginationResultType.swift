//
//  PaginationResultType.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Foundation
enum PaginationResultType {
    case noData
    case newData
    case insertData(indexs: [IndexPath])
}
