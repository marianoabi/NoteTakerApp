//
//  NoteRepository.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/2/25.
//

import Foundation
import Combine

class NoteRepository: NoteRepositoryProtocol {
    @Published private var notes: [Note] = []
    var notesPublisher: Published<[Note]>.Publisher { $notes }
    
    private let storage: StorageProtocol
    private let storageKey = "savedNotes"
    
    init(storage: StorageProtocol) {
        self.storage = storage
        loadNotes()
    }
    
    func getAllNotes() -> [Note] {
        return notes
    }

    
    func addNote(_ note: Note) {
        notes.insert(note, at: 0)
    }
    
    func searchNotes(searchText: String) -> [Note] {
        if searchText.isEmpty {
            return notes
        } else {
            return notes.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.content.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    private func saveNotes() {
        try? storage.save(notes, forKey: storageKey)
    }
    
    func updateNote(_ note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index] = note
            saveNotes()
        }
    }
    
    func deleteNote(withId id: UUID) {
        if let index = notes.firstIndex(where: { $0.id == id }) {
            notes.remove(at: index)
            saveNotes()
        }
    }
    
    private func loadNotes() {
        do {
            notes = try storage.load(forKey: storageKey)
            if notes.isEmpty {
                createSampleNotes()
            }
        } catch {
            createSampleNotes()
        }
    }
    
    private func createSampleNotes() {
        notes = [
            Note(title: "Welcome to Notes App", content: "This is a sample note to help you get started. Swipe left to delete or tap to edit", dateCreated: Date(), dateModified: Date(), color: .blue),
            Note(title: "Shopping List", content: "- Milk\n- Eggs\n- Bread\n- Butter", dateCreated: Date(), dateModified: Date(), color: .yellow),
            Note(title: "Project Ideas", content: "1. Learn SwiftUI\n2. Build portfolio app\n3. Update resumè", dateCreated: Date(), dateModified: Date(), color: .green)
        ]
        saveNotes()
    }
}
