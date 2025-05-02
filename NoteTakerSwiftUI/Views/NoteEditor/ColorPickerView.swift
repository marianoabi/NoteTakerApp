//
//  ColorPickerView.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/2/25.
//

import SwiftUI

struct ColorPickerView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(NoteColor.allCases, id: \.self) { color in
                    Circle()
                        .fill(color.color)
                        .frame(width: 30, height: 30)
                        .overlay(
                            Circle()
                                .stroke(Color.primary, lineWidth: 0)
                                .padding(2)
                        )
                }
            }
        }
    }
}

#Preview {
    ColorPickerView()
}
