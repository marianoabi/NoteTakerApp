//
//  ColorPickerAccessibilityHelper.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/10/25.
//

import SwiftUI

struct ColorPickerAccessibilityHelper {
    static func containerLabel() -> String {
        return "Color selector"
    }
    
    static func colorLabel(for color: NoteColor) -> String {
        return "\(color.accessibilityDescription) color"
    }
    
    static func colorHint() -> String {
        return "Double tap to select this color for your note"
    }
}
