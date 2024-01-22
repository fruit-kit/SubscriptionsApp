//
//  UINavigationController+Title.swift
//  Subscriptions
//
//  Created by Robert Kotrutsa on 16.11.2023.
//

import Foundation
import UIKit

extension UINavigationController {
    
    
    func setupTitle(for viewController: UIViewController, with title: String) {
        
        viewController.title = title
    }
}
