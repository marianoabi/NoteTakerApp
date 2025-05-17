//
//  DynamicTypeSize.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/10/25.
//

import SwiftUI

extension DynamicTypeSize {
    var isAccessibilitySize: Bool {
        self >= .accessibility1
    }
    
    var scaleFactor: CGFloat {
        switch self {
        case .xSmall: return 0.8
        case .small: return 0.9
        case .medium: return 1.0
        case .large: return 1.1
        case .xLarge: return 1.2
        case .xxLarge: return 1.3
        case .xxxLarge: return 1.4
        case .accessibility1: return 1.6
        case .accessibility2: return 1.8
        case .accessibility3: return 2.0
        case .accessibility4: return 2.2
        case .accessibility5: return 2.4
        @unknown default: return 1.0
        }
    }
    
    func scaledSize(_ baseSize: CGFloat) -> CGFloat {
        return baseSize * scaleFactor
    }
}
