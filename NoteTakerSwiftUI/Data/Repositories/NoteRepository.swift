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
    private let storageKey = StringConstants.StorageKeys.savedNotes
    
    init(storage: StorageProtocol) {
        self.storage = storage
        loadNotes()
    }
    
    deinit {
        print(StringConstants.App.dealloc.formatted(with: String(describing: Self.self)))
    }
    
    func getAllNotes() -> [Note] {
        return notes
    }

    
    func addNote(_ note: Note) {
        notes.insert(note, at: 0)
        saveNotes()
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
            Note(title: StringConstants.SampleNotes.welcomeTitle, content: StringConstants.SampleNotes.welcomeContent, dateCreated: Date(), dateModified: Date(), color: .blue),
            Note(title: StringConstants.SampleNotes.shoppingTitle, content: StringConstants.SampleNotes.shoppingContent, dateCreated: Date(), dateModified: Date(), color: .yellow),
            Note(title: StringConstants.SampleNotes.projectTitle, content: StringConstants.SampleNotes.projectContent, dateCreated: Date(), dateModified: Date(), color: .green)
        ]
        saveNotes()
    }
}
