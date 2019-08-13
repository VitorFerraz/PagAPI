//
//  DetailViewController.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import UIKit
class DetailViewController: AbstractViewController<DetailViewModel> {
    @IBOutlet weak var ivLogo: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbAbv: UILabel!
    @IBOutlet weak var lbIbu: UILabel!
    
    var beer: Beer?
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.contentInset = UIEdgeInsets(top: imageHeight.constant, left: 0, bottom: 0, right: 0)
        vm.model = beer
        setupUI()
        
    }
    
    private func setupUI(){
        ivLogo.kf.indicatorType = .activity
        ivLogo.kf.setImage(with: vm.logoUrl)
        lbTitle.text = vm.name
        lbDescription.text = vm.description
        lbAbv.text = vm.abv
        lbIbu.text = vm.ibu
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
  
    }
    
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        imageHeight.constant = max(-scrollView.contentOffset.y, 0)
    }
}
