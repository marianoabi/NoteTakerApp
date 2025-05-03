//
//  NoteEditorView.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/2/25.
//


import SwiftUI

struct NoteEditorView: View {
    @ObservedObject var viewModel: NoteEditorViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Note title", text: $viewModel.title)
                }
                
                Section(header: Text("Content")) {
                    TextField("Note content", text: $viewModel.content)
                        .frame(minHeight: 200)
                }
                
                Section(header: Text("Color")) {
                    ColorPickerView(selectedColor: $viewModel.selectedColor)
                }
            }
            .navigationTitle(viewModel.isNewNote ? "New Note" : "Edit Note")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        viewModel.saveNote()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(viewModel.title.isEmpty)
                }
            }
        }
    }
}

#Preview {
    NoteEditorView(viewModel: NoteEditorViewModel(repository: NoteRepository(storage: UserDefaultsStorage())))
}
