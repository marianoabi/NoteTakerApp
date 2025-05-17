//
//  DynamicTextHelper.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/10/25.
//

import SwiftUI

enum TextStyle {
    case title
    case body
    case caption
    
    var fontSize: CGFloat {
        switch self {
        case .title:
            return 20
        case .body:
            return 16
        case .caption:
            return 12
        }
    }
    
    var scalingFactor: CGFloat {
        switch self {
        case .title:
            return 1.3
        case .body:
            return 1.0
        case .caption:
            return 0.9
        }
    }
    
    var font: Font {
        switch self {
        case .title:
            return .system(size: fontSize, weight: .bold, design: .default)
        case .body:
            return .system(size: fontSize, weight: .regular, design: .default)
        case .caption:
            return .system(size: fontSize, weight: .light, design: .default)
        }
    }
}

struct DynamicText: View {
    let text: String
    let style: TextStyle
    let maxLines: Int?
    let fixedSizeHorizontal: Bool
    let fixedSizeVertical: Bool
    init(_ text: String, style: TextStyle, maxLines: Int? = nil, fixedSizeHorizontal: Bool = false, fixedSizeVertical: Bool = false) {
        self.text = text
        self.style = style
        self.maxLines = maxLines
        self.fixedSizeHorizontal = fixedSizeHorizontal
        self.fixedSizeVertical = fixedSizeVertical
    }
    var body: some View {
        Text(text)
            .font(style.font)
            .lineLimit(maxLines)
//            .dynamicTypeSize(.xSmall ... .accessibility5) // Limit range to prevent extreme scaling
            .fixedSize(horizontal: fixedSizeHorizontal, vertical: fixedSizeVertical)
    }
}
