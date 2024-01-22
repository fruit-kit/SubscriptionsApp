//
//  Extension + String.swift
//  Subscriptions
//
//  Created by Robert Kotrutsa on 12.12.2023.
//

import Foundation

extension String {
    
    func localized() -> String {
        
        NSLocalizedString(self,
                          tableName: "Localizable",
                          bundle: .main, value: self,
                          comment: self)
    }
}
