//
//  PunkBeerCellViewModel.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Foundation
struct PunkBeerCellViewModel {
    let name: String, value: String, imageUrl: URL?
    
    init(model: Beer ) {
        self.name = model.name ?? ""
        self.value = String(format: "%.2f%%", model.abv ?? 0.0)
        if let image = model.image, let url = URL(string: image) {
            self.imageUrl = url
 
        } else {
            self.imageUrl = nil
        }
    }
}
