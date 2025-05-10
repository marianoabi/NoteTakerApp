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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(note.title)
                .font(.headline)
                .lineLimit(1)
            
            Text(note.content)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)
            
            HStack {
                Text(dateFormatter.formatDate(note.dateModified))
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                Spacer()
                
                Circle()
                    .fill(note.color.color)
                    .frame(width: 12, height: 12)
            }
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(NoteAccessibilityHelper.label(for: note))
        .accessibilityHint(NoteAccessibilityHelper.hint())
        .accessibilityValue(Text(NoteAccessibilityHelper.value(for: note, formattedDate: dateFormatter.formatDate(note.dateModified))))
    }
}

#Preview {
    NoteRowView(note: Note(title: "What's up?", content: "Doing something", dateCreated: Date(), dateModified: Date()), dateFormatter: DateFormatterService())
}
