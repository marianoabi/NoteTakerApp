//
//  ViewModelFactory.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/4/25.
//

import Foundation

class ViewModelFactory: ViewModelFactoryProtocol {
    private let repository: NoteRepositoryProtocol
    
    init(repository: NoteRepositoryProtocol? = nil) {
        if let repo = repository {
            self.repository = repo
        } else {
            self.repository = NoteRepository(storage: UserDefaultsStorage())
        }
    }
    
    func makeNoteListViewModel() -> NoteListViewModel {
        return NoteListViewModel(repository: repository)
    }
    
    func makeNoteEditorViewModel(note: Note?) -> NoteEditorViewModel {
        return NoteEditorViewModel(repository: repository, note: note)
    }
    
    func makeDateFormatterService() -> DateFormatterServiceProtocol {
        return DateFormatterService()
    }
}
