//
//  NoteListViewModel.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/2/25.
//

import Foundation
import Combine

class NoteListViewModel: ObservableObject {
    @Published var filteredNotes: [Note] = []
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    private let repository: NoteRepositoryProtocol
    
    init(repository: NoteRepositoryProtocol) {
        self.repository = repository
        
        repository.notesPublisher
            .combineLatest($searchText)
            .map { [weak self] notes, searchText in
                guard let self = self else { return [] }
                if searchText.isEmpty {
                    return notes
                } else {
                    return self.repository.searchNotes(searchText: searchText)
                }
            }
            .sink(receiveValue: { [weak self] value in
                self?.filteredNotes = value
            })
            .store(in: &cancellables)
        
    }
    
    func deleteNote(at index: Int) {
        let noteId = filteredNotes[index].id
        repository.deleteNote(withId: noteId)
    }
    
    deinit {
        print("NoteListViewModel deallocated")
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}
