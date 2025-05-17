//
//  PremiumFeature.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/17/25.
//

import Foundation

enum PremiumFeature: String, CaseIterable {
    case attachments
    case advancedColors
    case export
    case cloudSync
    
    static let productID = "com.marianoabi.NoteTakerSwiftUI.premium.monthly"
    
    var title: String {
        switch self {
        case .attachments:
            return "File Attachments"
        case .advancedColors:
            return "Advanced Color Options"
        case .export:
            return "Export to PDF/Word"
        case .cloudSync:
            return "Cloud Synchronization"
        }
    }
    
    var description: String {
        switch self {
        case .attachments:
            return "Attach files, images and documents to your notes"
        case .advancedColors:
            return "Access to additional color themes and customization options"
        case .export:
            return "Export your notes to PDF or Word format"
        case .cloudSync:
            return "Sync your notes across all your devices"
        }
    }
    
    var iconName: String {
        switch self {
        case .attachments:
            return "paperclip"
        case .advancedColors:
            return "paintpalette"
        case .export:
            return "square.and.arrow.up"
        case .cloudSync:
            return "icloud"
        }
    }
}
