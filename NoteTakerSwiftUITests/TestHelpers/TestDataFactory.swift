//
//  TestDataFactory.swift
//  NoteTakerSwiftUITests
//
//  Created by Abigail Mariano on 5/7/25.
//

import Foundation
@testable import NoteTakerSwiftUI

struct TestDataFactory {
    static func createTestNotes(count: Int = 3) -> [Note] {
        var notes: [Note] = []
        
        for i in 0..<count {
            notes.append(createTestNote(index: i))
        }
        
        return notes
    }
    
    static func createTestNote(
        id: UUID = UUID(),
        index: Int = 0,
        title: String? = nil,
        content: String? = nil,
        dateCreated: Date? = nil,
        dateModified: Date? = nil,
        color: NoteColor? = nil
    ) -> Note {
        
        let testTitles = ["Welcome Note", "Shopping List", "Project Ideas", "Meeting Notes", "Recipes"]
        let testContents = [
            "This is a sample note to help you get started.",
            "Milk, Eggs, Bread, Butter, Coffee",
            "Learn SwiftUI, Build a portfolio app, Create a note-taking app",
            "Discuss project timeline, Review requirements, Assign tasks",
            "Pasta carbonara, Chocolate cake, Chicken curry"
        ]
        let testColors: [NoteColor] = [.blue, .green, .red, .yellow, .purple]
        
        // Use provided values or defaults based on index
        let safeIndex = min(index, 4) // Ensure we don't go out of bounds
        
        return Note(
            id: id,
            title: title ?? testTitles[safeIndex],
            content: content ?? testContents[safeIndex],
            dateCreated: dateCreated ?? Date().addingTimeInterval(-Double(86400 * safeIndex)), // Subtract days
            dateModified: dateModified ?? Date().addingTimeInterval(-Double(3600 * safeIndex)), // Subtract hours
            color: color ?? testColors[safeIndex]
        )
    }
}
