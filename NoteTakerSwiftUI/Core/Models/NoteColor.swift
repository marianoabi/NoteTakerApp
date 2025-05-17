//
//  NoteColor.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/2/25.
//

import SwiftUI

enum NoteColor: String, Codable, CaseIterable {
    
    // basic colors
    case blue, red, green, yellow
    
    // premium
    case orange, pink, teal, indigo, brown
    
    var color: Color {
        switch self {
        case .blue:
            return .blue
        case .red:
            return .red
        case .green:
            return .green
        case .yellow:
            return .yellow
        case .orange:
            return .orange
        case .pink:
            return .pink
        case .teal:
            return .teal
        case .indigo:
            return .indigo
        case .brown:
            return .brown
        }
    }
    
    var accessibilityDescription: String {
        switch self {
        case .blue:
            return "Blue"
        case .red:
            return "Red"
        case .green:
            return "Green"
        case .yellow:
            return "Yellow"
        case .orange:
            return "Orange"
        case .pink:
            return "Pink"
        case .teal:
            return "Teal"
        case .indigo:
            return "Indigo"
        case .brown:
            return "Brown"
        }
    }
    
    var isPremium: Bool {
        switch self {
        case .blue, .red, .green, .yellow:
            return false
        case .orange, .pink, .teal, .indigo, .brown:
            return true
        }
    }
    
    static var basicColors: [NoteColor] {
        return [.blue, .red, .green, .yellow]
    }
    
    static var premiumColors: [NoteColor] {
        return [.orange, .pink, .teal, .indigo, .brown]
    }
}
