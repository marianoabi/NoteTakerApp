//
//  NoteColor.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/2/25.
//

import SwiftUI

enum NoteColor: String, Codable, CaseIterable {
    case blue, red, green, yellow, purple
    
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
        case .purple:
            return .purple
        }
    }
}
