//
//  MVVMAbastract.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import UIKit

internal protocol MVVMPresentable {
    associatedtype ViewModel: ViewModelPresentable
    var vm: ViewModel {get}
    init()
}

public protocol ViewModelPresentable {
    init()
}


open class AbstractViewController<T: ViewModelPresentable>: UIViewController, MVVMPresentable {
    typealias ViewModel = T
    
    public var vm: T
    
    required public init() {
        vm = T()
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        vm = T()
        super.init(coder: aDecoder)
    }
}
