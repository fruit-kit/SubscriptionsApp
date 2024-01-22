//
//  Decimal+Float.swift
//  Subscriptions
//
//  Created by Yury Vozleev on 22.11.2023.
//

import Foundation

extension Decimal {
    
    var floatValue: Float {
        
        let nsDecimal = self as NSDecimalNumber
        
        return nsDecimal.floatValue
    }
}
