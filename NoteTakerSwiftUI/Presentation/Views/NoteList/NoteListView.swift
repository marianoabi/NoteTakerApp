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
                        .onTapGesture {
                            selectedNote = note
                        }
                }
                .onDelete { indexSet in
                    indexSet.forEach { viewModel.deleteNote(at: $0) }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showingNewNoteView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search notes")
            .sheet(isPresented: $showingNewNoteView) {
                NoteEditorView(viewModel: factory.makeNoteEditorViewModel(note: nil))
            }
            .sheet(item: $selectedNote) { note in
                NoteEditorView(viewModel: factory.makeNoteEditorViewModel(note: note))
            }
        }
    }
}

#Preview {
    NoteListView(factory: ViewModelFactory(repository: NoteRepository(storage: UserDefaultsStorage())))
}
