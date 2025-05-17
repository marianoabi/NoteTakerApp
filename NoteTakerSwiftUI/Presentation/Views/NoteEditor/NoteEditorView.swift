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
                        .font(.system(size: 17)) // Use system font for text field
                        .dynamicTypeSize(.xSmall ... .accessibility5)
                        .accessibilityLabel("Note Title")
                        .accessibilityHint("Enter the title for your note")
                }
                
                Section(header: Text("Content")) {
                    TextField("Note content", text: $viewModel.content)
                        .font(.system(size: 17)) // Use system font for text field
                        .dynamicTypeSize(.xSmall ... .accessibility5)
                        .frame(minHeight: 200)
                        .accessibilityLabel("Note content")
                        .accessibilityHint("Enter the content for your note")
                }
                
                Section(header: Text("Color")) {
                    ColorPickerView(selectedColor: $viewModel.selectedColor, isPremiumUser: viewModel.isPremiumUser)
                        .accessibilityLabel("Note color")
                        .accessibilityHint("Select a color for your note")
                }
            }
            .navigationTitle(viewModel.isNewNote ? "New Note" : "Edit Note")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .accessibilityLabel("Cancel")
                    .accessibilityHint("Discard changes and return to notes list")
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        viewModel.saveNote()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(viewModel.title.isEmpty)
                    .accessibilityLabel("Save note")
                    .accessibilityHint(viewModel.title.isEmpty ? "Button is disabled, add a title to enable" : "Save your note and return to notes list")
                }
            }
        }
    }
}

#Preview {
    NoteEditorView(viewModel: NoteEditorViewModel(repository: NoteRepository(storage: UserDefaultsStorage()), iapService: IAPService()))
}
