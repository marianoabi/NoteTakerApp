//
//  NoteUseCase.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/18/25.
//

import Foundation

class NoteUseCase: NoteUseCaseProtocol {
    private let repository: NoteRepositoryProtocol
    
    init(repository: NoteRepositoryProtocol) {
        self.repository = repository
    }
    
    var notesPublisher: Published<[Note]>.Publisher {
        return repository.notesPublisher
    }
    
    func getAllNotes() -> [Note] {
        return repository.getAllNotes()
    }
    
    func addNote(title: String, content: String, color: NoteColor) -> Note {
        let newNote = Note(
            title: title,
            content: content,
            dateCreated: Date(),
            dateModified: Date(),
            color: color
        )
        repository.addNote(newNote)
        return newNote
    }
    
    func updateNote(id: UUID, title: String, content: String, color: NoteColor) {
        guard let existingNote = repository.getAllNotes().first(where: { $0.id == id }) else {
            return
        }
        
        let updatedNote = Note(
            id: id,
            title: title,
            content: content,
            dateCreated: existingNote.dateCreated,
            dateModified: Date(),
            color: color
        )
        
        repository.updateNote(updatedNote)
    }
    
    func deleteNote(withId id: UUID) {
        repository.deleteNote(withId: id)
    }
    
    func searchNotes(searchText: String) -> [Note] {
        return repository.searchNotes(searchText: searchText)
    }
}
