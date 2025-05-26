//
//  NoteAccessibilityHelper.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/10/25.
//

import Foundation

struct NoteAccessibilityHelper {
    static func label(for note: Note) -> String {
        return "Note: \(note.title)"
    }
    
    static func hint() -> String {
        return StringConstants.Accessibility.noteTapHint
    }
    
    static func value(for note: Note, formattedDate: String) -> String {
        return "Last modified \(formattedDate). Content: \(note.content)"
    }
}
