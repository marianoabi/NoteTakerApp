//
//  NoteListView.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/2/25.
//

import SwiftUI

struct NoteListView: View {
    @StateObject private var viewModel: NoteListViewModel
    @State private var showingNewNoteView = false
    @State private var selectedNote: Note?
    
    private let factory: ViewModelFactory
    
    init(factory: ViewModelFactory) {
        self.factory = factory
        _viewModel = .init(wrappedValue: factory.makeNoteListViewModel())
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.filteredNotes) { note in
                    NoteRowView(note: note, dateFormatter: factory.makeDateFormatterService())
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search notes")
        }
    }
}

#Preview {
    NoteListView(factory: ViewModelFactory(repository: NoteRepository(storage: UserDefaultsStorage())))
}
