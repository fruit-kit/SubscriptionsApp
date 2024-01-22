//
//  SubManager.swift
//  Subscriptions
//
//  Created by Robert Kotrutsa on 02.11.2023.
//

import Foundation
import UIKit

// MARK: - Subscription

struct Subscription: Codable {
    
    var subType: SubType
    var subscriptionTerm: String?
    var subPrices: [Double]
    var currentPrice: Decimal?
    var additionalInformation: [String]
    var currentDescription: String?
    
    enum CodingKeys: String, CodingKey {
        
        case subType
        case subscriptionTerm
        case subPrices
        case currentPrice
        case additionalInformation
        case currentDescription
    }
}

// MARK: - SubType

enum SubType: String, Codable {
    
    case Netflix
    case iCloud
    case AppleMusic
    case AppleTV
    case AppleArcade
    case AppleNews
    case AppleFitness
    case AppleOne
    case Google
    case Spotify
    case XboxGamePass
    case PlayStationNow
    case Audible
    case iVi
    case Megogo
    case YouTube
    
    var image: UIImage? {
        
        switch self {
            
        case .Netflix:
            return UIImage(named: IconNames.netflix)
        case .iCloud:
            return UIImage(named: IconNames.icloud)
        case .AppleMusic:
            return UIImage(named: IconNames.appleMusic)
        case .AppleTV:
            return UIImage(named: IconNames.appleTv)
        case .AppleArcade:
            return UIImage(named: IconNames.appleArcade)
        case .AppleNews:
            return UIImage(named: IconNames.appleNews)
        case .AppleFitness:
            return UIImage(named: IconNames.appleFitness)
        case .AppleOne:
            return UIImage(named: IconNames.appleOne)
        case .Google:
            return UIImage(named: IconNames.google)
        case .Spotify:
            return UIImage(named: IconNames.spotify)
        case .XboxGamePass:
            return UIImage(named: IconNames.xboxGamePass)
        case .PlayStationNow:
            return UIImage(named: IconNames.playStationNow)
        case .Audible:
            return UIImage(named: IconNames.audible)
        case .iVi:
            return UIImage(named: IconNames.ivi)
        case .Megogo:
            return UIImage(named: IconNames.megogo)
        case .YouTube:
            return UIImage(named: IconNames.youtube)
        }
    }
}
