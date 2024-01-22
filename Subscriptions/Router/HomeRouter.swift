//
//  MainRouter.swift
//  Subscriptions
//
//  Created by Robert Kotrutsa on 18.11.2023.
//

import Foundation
import UIKit

// MARK: - SettingsRouter

protocol HomeRouter {
    
    func openSubList(from viewController: UIViewController, animated: Bool)
}

// MARK: - Router Extension

extension Router: HomeRouter {
    
    func openSubList(from viewController: UIViewController, animated: Bool) {
        
        let subListViewController = SubListViewController(nibName: NibNames.subListViewController, bundle: nil)
        
        viewController.navigationController?.pushViewController(subListViewController, animated: animated)
    }
    
}
