//
//  MockNoteRepository.swift
//  NoteTakerSwiftUITests
//
//  Created by Abigail Mariano on 5/7/25.
//

import Foundation
import Combine
@testable import NoteTakerSwiftUI

class MockNoteRepository: NoteRepositoryProtocol {
    @Published private var notes: [Note] = [
        Note(title: "Welcome to Notes App", content: "This is a sample note", dateCreated: Date(), dateModified: Date()),
        Note(title: "Shopping List", content: "Milk, Eggs, Bread", dateCreated: Date(), dateModified: Date()),
        Note(title: "Project Ideas", content: "Learn SwiftUI", dateCreated: Date(), dateModified: Date())
    ]
    
    var notesPublisher: Published<[NoteTakerSwiftUI.Note]>.Publisher { $notes }
    
    func getAllNotes() -> [NoteTakerSwiftUI.Note] {
        return notes
    }
    
    func addNote(_ note: NoteTakerSwiftUI.Note) {
        notes.insert(note, at: 0)
    }
    
    func searchNotes(searchText: String) -> [NoteTakerSwiftUI.Note] {
        if searchText.isEmpty {
            return notes
        } else {
            return notes.filter {
                $0.title.contains(searchText) || $0.content.contains(searchText)
            }
        }
    }
    
    func updateNote(_ note: NoteTakerSwiftUI.Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index] = note
        }
    }
    
    func deleteNote(withId id: UUID) {
        if let index = notes.firstIndex(where: { $0.id == id }) {
            notes.remove(at: index)
        }
    }
}
