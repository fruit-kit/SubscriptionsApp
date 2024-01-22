//
//  Utilities.swift
//  Subscriptions
//
//  Created by Robert Kotrutsa on 20.11.2023.
//

import Foundation

// MARK: - Nib Names

struct NibNames {
    
    static let subListCell = "SubListTableViewCell"
    static let subPlanViewController = "SubPlanViewController"
    static let subListViewController = "SubListViewController"
    static let subCell = "SubTableViewCell"
    static let settingsTableViewCell = "SettingsTableViewCell"
}

// MARK: - Icon Names

struct IconNames {
    
    static let netflix = "icon-netflix"
    static let icloud = "icon-icloud"
    static let google = "icon-google"
    static let spotify = "icon-spotify"
    static let appleMusic = "apple-music-icon"
    static let appleTv = "apple-tv-icon"
    static let appleArcade = "apple-arcade-icon"
    static let appleNews = "apple-news-icon"
    static let appleFitness = "apple-fitness-icon"
    static let appleOne = "apple-one-icon"
    static let xboxGamePass = "xbox-game-pass-icon"
    static let playStationNow = "play-station-now-icon"
    static let audible = "audible-icon"
    static let ivi = "ivi-icon"
    static let megogo = "megogo-icon"
    static let youtube = "youtube-icon"
}

// MARK: - Default Values

struct DefaultValues {
    
    static let defaultImage = "no-image"
    static let selectPlanTitle = "Select Plan".localized()
    static let subscriptionsTitle = "Subscriptions".localized()
    static let settingsTitle = "Settings".localized()
    static let subListTitle = "Select Subscription".localized()
    static let totalCostLabel = "Total cost of subscriptions \n$0.00"
    static let personalInfo = "Personal info".localized()
    static let defaultTextOfDescription = "Cost per month: $0.00"
    static let defaultTitleOfDescription = "Subscription Name"
}

// MARK: - Error Messages

struct ErrorMessages {
    
    static let segmentControlNil = "Error: selectPlanSegmentControl is nil"
    static let titleOfDescriptionKey = "titleOfDescription"
    static let selectedSubscriptionKey = "selectedSubscription"
    static let errorNilMessage = "Error: \(ErrorMessages.titleOfDescriptionKey) or \(ErrorMessages.selectedSubscriptionKey) is nil"
    static let descriptionImageKey = "descriptionImage"
    static let errorNilImageMessage = "Error: \(ErrorMessages.descriptionImageKey) is nil"
    static let subscriptionImageNil = "Error: Subscription image is nil"
    static let selectedSubscriptionNil = "Error: selectedSubscription is nil"
}

// MARK: - Animation Names

struct AnimationNames {
    
    static let plus = "animation-plus"
}
