//
//  IAPProductType.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/17/25.
//

import Foundation
import StoreKit

enum IAPProductType: String, CaseIterable {
    case premium = "com.marianoabi.NoteTakerSwiftUI.premium"
    case premiumMonthly = "com.marianoabi.NoteTakerSwiftUI.premium.monthly"
    
    var id: String {
        return self.rawValue
    }
    
    var name: String {
        switch self {
        case .premium:
            return "Premium Feature"
        case .premiumMonthly:
            return "Premium Monthly"
        }
    }
    
    var description: String {
        switch self {
        case .premium:
            return "Unlock all premium features permanently"
        case .premiumMonthly:
            return "Access all premium features with a monthly subscription"
        }
    }
    
    var features: [PremiumFeature] {
        return PremiumFeature.allCases
    }
    
    static func productType(from productID: String) -> IAPProductType? {
        return IAPProductType.allCases.first { $0.id == productID }
    }
}

struct IAPProductViewModel {
    let product: Product
    let isPurchased: Bool
    
    var formattedPrice: String {
        return product.displayPrice
    }
    
    var displayName: String {
        return product.displayName
    }
    
    var localizedDescription: String {
        return product.description
    }
    
    var features: [PremiumFeature] {
        return PremiumFeature.allCases
    }
}
