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
    private let useCase: NoteUseCaseProtocol
    
    init(useCase: NoteUseCaseProtocol) {
        self.useCase = useCase
        
        useCase.notesPublisher
            .combineLatest($searchText)
            .map { [weak self] notes, searchText in
                guard let self = self else { return [] }
                if searchText.isEmpty {
                    return notes
                } else {
                    return self.useCase.searchNotes(searchText: searchText)
                }
            }
            .sink(receiveValue: { [weak self] value in
                self?.filteredNotes = value
            })
            .store(in: &cancellables)
        
    }
    
    func deleteNote(at index: Int) {
        let noteId = filteredNotes[index].id
        useCase.deleteNote(withId: noteId)
    }
    
    deinit {
        print("NoteListViewModel deallocated")
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}
