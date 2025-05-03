//
//  NoteEditorViewModel.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/4/25.
//

import Foundation

class NoteEditorViewModel: ObservableObject {
    @Published var title: String
    @Published var content: String
    @Published var selectedColor: NoteColor
    
    private let repository: NoteRepositoryProtocol
    private let noteId: UUID?
    private let dateCreated: Date
    
    var isNewNote: Bool {
        return noteId == nil
    }
    
    init(repository: NoteRepositoryProtocol, note: Note? = nil) {
        self.repository = repository
        self.title = note?.title ?? ""
        self.content = note?.content ?? ""
        self.selectedColor = note?.color ?? .blue
        self.noteId = note?.id
        self.dateCreated = note?.dateCreated ?? Date()
    }
    
    func saveNote() {
        if isNewNote {
            let newNote = Note(title: title, content: content, dateCreated: Date(), dateModified: Date(), color: selectedColor)
            repository.addNote(newNote)
        } else if let id = noteId {
            let updateNote = Note(id: id,title: title, content: content, dateCreated: dateCreated, dateModified: Date(), color: selectedColor)
            repository.updateNote(updateNote)
        }
    }
}
