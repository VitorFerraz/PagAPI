//
//  GenericListModel.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Foundation
public class GenericListModel<T: ModelInterface>: ModelInterface {
    public var objects: [T]?
    public var offset: Int?
    public var total: Int?
    public var hasNextPage: Bool = true
    
    public required init() { }
    
    public init(objects: [T]?, offset: Int?, total: Int?) {
        self.objects = objects
        self.offset = offset
        self.total = total
    }
}
