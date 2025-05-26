//
//  ColorPickerAccessibilityHelper.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/10/25.
//

import SwiftUI

struct ColorPickerAccessibilityHelper {
    static func containerLabel() -> String {
        return StringConstants.Accessibility.colorSelector
    }
    
    static func colorLabel(for color: NoteColor) -> String {
        return "\(color.accessibilityDescription) color"
    }
    
    static func colorHint() -> String {
        return StringConstants.Accessibility.colorHint
    }
}
