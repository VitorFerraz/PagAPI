//
//  TableView+PullToRefresh.swift
//  PunkBeer
//
//  Created by Vitor Ferraz Varela on 12/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import UIKit
extension UITableView {
    fileprivate struct AssociatedObjectKeys {
        static var refreshContolHandler: UInt8 = 0
    }
    
    fileprivate typealias Action = (_ refreshControl: UIRefreshControl)-> Swift.Void?
    
    fileprivate var refreshControlAction: Action? {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectKeys.refreshContolHandler) as? Action
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectKeys.refreshContolHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func refreshControlHandler(block: @escaping (_ refreshControl: UIRefreshControl) -> Void) {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(UITableView.handleRefreshControlAction(sender:)), for: UIControl.Event.valueChanged)
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            self.refreshControl = refreshControl
        } else {
            self.addSubview(refreshControl)
        }
        
        refreshControlAction = block
    }
    
    @objc
    fileprivate func handleRefreshControlAction(sender : UIRefreshControl) {
        self.refreshControlAction?(sender)
    }
}
