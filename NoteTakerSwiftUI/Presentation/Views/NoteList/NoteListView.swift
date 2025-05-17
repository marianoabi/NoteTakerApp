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
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    private let factory: ViewModelFactory
    
    init(factory: ViewModelFactory) {
        self.factory = factory
        _viewModel = StateObject(wrappedValue: factory.makeNoteListViewModel())
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.filteredNotes) { note in
                    NoteRowView(note: note, dateFormatter: factory.makeDateFormatterService())
                        .onTapGesture {
                            selectedNote = note
                        }
                    // Add padding that scales with text size
                        .padding(.vertical, dynamicTypeSize.isAccessibilitySize ? 12 : 4)
                    // Ensure minimum row height scales with text
                        .frame(minHeight: rowHeight)
                }
                .onDelete { indexSet in
                    indexSet.forEach { viewModel.deleteNote(at: $0) }
                }
            }
            .listStyle(InsetGroupedListStyle())
            // This is important - it makes the list cells respond to dynamic type changes
            .environment(\.defaultMinListRowHeight, rowHeight)
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showingNewNoteView = true
                    }) {
                        Image(systemName: "plus")
                        // Make icon scale with text size
                            .imageScale(dynamicTypeSize.isAccessibilitySize ? .large : .medium)
                            .padding(dynamicTypeSize.isAccessibilitySize ? 6 : 0)
                    }
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search notes")
            .accessibilityAction(named: "Create New Note", {
                showingNewNoteView = true
            })
            .sheet(isPresented: $showingNewNoteView) {
                NoteEditorView(viewModel: factory.makeNoteEditorViewModel(note: nil))
            }
            .sheet(item: $selectedNote) { note in
                NoteEditorView(viewModel: factory.makeNoteEditorViewModel(note: note))
            }
        }
        // Force layout recalculation when dynamic type size changes
        .id(dynamicTypeSize)
    }
    
    private var rowHeight: CGFloat {
        switch dynamicTypeSize {
        case .xSmall, .small:
            return 60
        case .medium:
            return 70
        case .large, .xLarge:
            return 80
        case .xxLarge:
            return 90
        case .xxxLarge:
            return 100
        case .accessibility1:
            return 120
        case .accessibility2:
            return 140
        case .accessibility3:
            return 160
        case .accessibility4:
            return 180
        case .accessibility5:
            return 200
        @unknown default:
            return 80
        }
    }
}

#Preview {
    NoteListView(factory: ViewModelFactory(repository: NoteRepository(storage: UserDefaultsStorage())))
}
