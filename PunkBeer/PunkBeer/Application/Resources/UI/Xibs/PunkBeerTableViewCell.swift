//
//  PunkBeerTableViewCell.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import UIKit
import Kingfisher
class PunkBeerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivLogo: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAlcoholContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        clean()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clean()
    }
    
    final fileprivate func setup() {
        ivLogo.layer.cornerRadius = 6.0
        ivLogo.clipsToBounds = true
    }
    
    final fileprivate func clean() {
        ivLogo.image = nil
        lbAlcoholContent.text = nil
        lbAlcoholContent.text = nil
    }
}

extension PunkBeerTableViewCell {
    func contructWith(viewModel: PunkBeerCellViewModel) {
        lbName.text = viewModel.name
        lbAlcoholContent.text = viewModel.value
        ivLogo.kf.indicatorType = .activity
        ivLogo.kf.setImage(with: viewModel.imageUrl, placeholder: UIImage(named: "placeholderImg"))
    }
}
