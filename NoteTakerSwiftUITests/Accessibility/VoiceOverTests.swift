//
//  VoiceOverTests.swift
//  NoteTakerSwiftUITests
//
//  Created by Abigail Mariano on 5/10/25.
//

import XCTest
@testable import NoteTakerSwiftUI
import SwiftUI

final class VoiceOverTests: XCTestCase {
    
    func testNoteAccessibilityHelper() {
        // Given
        let note = Note(
            title: "Test Note",
            content: "Test Content",
            dateCreated: Date(),
            dateModified: Date(),
            color: .blue
        )
        let dateFormatter = DateFormatterService()
        let formattedDate = dateFormatter.formatDate(note.dateModified)
        
        // When
        let label = NoteAccessibilityHelper.label(for: note)
        let hint = NoteAccessibilityHelper.hint()
        let value = NoteAccessibilityHelper.value(for: note, formattedDate: formattedDate)
        
        // Then
        XCTAssertEqual(label, "Note: Test Note", "Accessibility label should contain the note title")
        XCTAssertEqual(hint, "Double tap to edit this note", "Accessibility hint should mention editing")
        XCTAssertTrue(value.contains("Last modified"), "Accessibility value should include modification date")
        XCTAssertTrue(value.contains("Content: Test Content"), "Accessibility value should include note content")
    }

    func testColorPickerAccessibilityHelper() {
        // Given
        let color = NoteColor.blue
        
        // When
        let containerLabel = ColorPickerAccessibilityHelper.containerLabel()
        let colorLabel = ColorPickerAccessibilityHelper.colorLabel(for: color)
        let colorHint = ColorPickerAccessibilityHelper.colorHint()
        
        // Then
        XCTAssertEqual(containerLabel, "Color selector")
        XCTAssertEqual(colorLabel, "Blue color")
        XCTAssertEqual(colorHint, "Double tap to select this color for your note")
    }
}
