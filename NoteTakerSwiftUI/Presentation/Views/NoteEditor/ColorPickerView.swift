//
//  ColorPickerView.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/2/25.
//
import SwiftUI

struct ColorPickerView: View {
    @Binding var selectedColor: NoteColor
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(NoteColor.allCases, id: \.self) { color in
                    Circle()
                        .fill(color.color)
                        .frame(width: 30, height: 30)
                        .overlay(
                            Circle()
                                .stroke(Color.primary, lineWidth: selectedColor == color ? 2 : 0)
                                .padding(2)
                        )
                        .onTapGesture(perform: { selectedColor = color })
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel(ColorPickerAccessibilityHelper.containerLabel())
                        .accessibilityAddTraits(selectedColor == color ? .isSelected : [])
                        .accessibilityHint(ColorPickerAccessibilityHelper.colorHint())
                }
            }
        }
        .accessibilityLabel("Color selector")
    }
}

#Preview {
    @Previewable @State var selectedColor: NoteColor = .yellow
    
    ColorPickerView(selectedColor: $selectedColor)
}
