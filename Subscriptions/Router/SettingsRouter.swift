//
//  SettingsRouter.swift
//  Subscriptions
//
//  Created by Robert Kotrutsa on 14.12.2023.
//

import Foundation
import UIKit

// MARK: - SettingsRouter

protocol SettingsRouter {
    
    func openSupportVC(from viewController: UIViewController, animated: Bool)
    
    func openSocialVC(from viewController: UIViewController, animated: Bool)
}

// MARK: - Router Extension

extension Router: SettingsRouter {
    
    func openSupportVC(from viewController: UIViewController, animated: Bool) {
        
        let supportViewController = SupportViewController(nibName: "SupportViewController", bundle: nil)
        
        viewController.navigationController?.pushViewController(supportViewController, animated: animated)
    }
    
    func openSocialVC(from viewController: UIViewController, animated: Bool) {
        
        let socialViewController = SocialViewController(nibName: "SocialViewController", bundle: nil)
        
        viewController.navigationController?.pushViewController(socialViewController, animated: animated)
    }
    
}
