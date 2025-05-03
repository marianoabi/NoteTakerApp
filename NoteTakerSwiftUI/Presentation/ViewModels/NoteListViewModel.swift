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
            .map { notes, searchText in
                if searchText.isEmpty {
                    return notes
                } else {
                    return self.repository.searchNotes(searchText: searchText)
                }
            }
            .assign(to: \.filteredNotes, on: self)
            .store(in: &cancellables)
        
    }
}
