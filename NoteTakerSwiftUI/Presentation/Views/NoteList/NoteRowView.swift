//
//  NoteRowView.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/2/25.
//

import SwiftUI

struct NoteRowView: View {
    let note: Note
    let dateFormatter: DateFormatterServiceProtocol
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    var body: some View {
        VStack(alignment: .leading, spacing: dynamicSpacing) {
            DynamicText(note.title, style: .title, maxLines: 1, fixedSizeVertical: true)
            DynamicText(note.content, style: .body, maxLines: dynamicTypeSize.isAccessibilitySize ? 3: 2, fixedSizeVertical: true)
                .foregroundStyle(.secondary)
            
            if dynamicTypeSize.isAccessibilitySize {
                // Vertical layout for large text sizes
                VStack(alignment: .leading, spacing: 4) {
                    Text(dateFormatter.formatDate(note.dateModified))
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    HStack {
                        Spacer()
                        Circle()
                            .fill(note.color.color)
                            .frame(width: 12, height: 12)
                            .accessibility(hidden: true)
                    }
                }
            } else {
                // Horizontal layout for standard text sizes
                HStack {
                    Text(dateFormatter.formatDate(note.dateModified))
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    Spacer()
                    
                    Circle()
                        .fill(note.color.color)
                        .frame(width: 12, height: 12)
                        .accessibility(hidden: true)
                }
            }
        }
        .padding(.vertical, dynamicSpacing)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(NoteAccessibilityHelper.label(for: note))
        .accessibilityHint(NoteAccessibilityHelper.hint())
        .accessibilityValue(Text(NoteAccessibilityHelper.value(for: note, formattedDate: dateFormatter.formatDate(note.dateModified))))
    }
    
    // Dynamic spacing based on text size
    private var dynamicSpacing: CGFloat {
        dynamicTypeSize.isAccessibilitySize ? 12 : 8
    }
}

#Preview {
    NoteRowView(note: Note(title: "What's up?", content: "Doing something", dateCreated: Date(), dateModified: Date()), dateFormatter: DateFormatterService())
}
