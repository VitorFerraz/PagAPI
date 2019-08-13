//
//  DetailViewModel.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Foundation
protocol DetailViewModelPresentable: ViewModelPresentable {
    var name: String {get}
    var abv: String {get}
    var ibu: String {get}
    var description: String {get}
    var logoUrl: URL? {get}
    var model: Beer? {get}
}

struct DetailViewModel: DetailViewModelPresentable {
    var model: Beer?

    var name: String {
        return "\(model?.name ?? "") | Tagline: \(model?.tagline ?? "")"
    }
    
    var abv: String {
        return String(format: "Teor alcoólico: %.2f%%", model?
            .abv ?? 0.0)
    }
    
    var ibu: String {
        return String(format: "Escala de amargor: %.2f%", model?
            .ibu ?? 0.0)
    }
    
    var description: String {
        return  model?.description ?? ""
    }
    
    var logoUrl: URL? {
        if let image = model?.image, let url = URL(string: image) {
            return url
            
        } else {
            return nil
        }
    }
}
