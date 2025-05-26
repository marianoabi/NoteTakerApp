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
                Section(header: Text(StringConstants.UI.title)) {
                    TextField(StringConstants.UI.noteTitle, text: $viewModel.title)
                        .font(.system(size: 17)) // Use system font for text field
                        .dynamicTypeSize(.xSmall ... .accessibility5)
                        .accessibilityLabel(StringConstants.Accessibility.noteTitle)
                        .accessibilityHint(StringConstants.Accessibility.noteTitleHint)
                }
                
                Section(header: Text(StringConstants.UI.content)) {
                    TextField(StringConstants.Accessibility.noteContent, text: $viewModel.content)
                        .font(.system(size: 17)) // Use system font for text field
                        .dynamicTypeSize(.xSmall ... .accessibility5)
                        .frame(minHeight: 200)
                        .accessibilityLabel(StringConstants.Accessibility.noteContent)
                        .accessibilityHint(StringConstants.Accessibility.noteContentHint)
                }
                
                Section(header: Text(StringConstants.UI.color)) {
                    ColorPickerView(selectedColor: $viewModel.selectedColor, isPremiumUser: viewModel.isPremiumUser)
                        .accessibilityLabel(StringConstants.Accessibility.noteColor)
                        .accessibilityHint(StringConstants.Accessibility.noteColorHint)
                }
            }
            .navigationTitle(viewModel.isNewNote ? StringConstants.UI.newNote : StringConstants.UI.editNote)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(StringConstants.UI.cancel) {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .accessibilityLabel(StringConstants.Accessibility.cancel)
                    .accessibilityHint(StringConstants.Accessibility.cancelHint)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(StringConstants.UI.save) {
                        viewModel.saveNote()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(viewModel.title.isEmpty)
                    .accessibilityLabel(StringConstants.Accessibility.saveNote)
                    .accessibilityHint(viewModel.title.isEmpty ? StringConstants.Accessibility.disabledButton : StringConstants.Accessibility.saveNoteLong)
                }
            }
        }
    }
}

#Preview {
    NoteEditorView(viewModel: NoteEditorViewModel(useCase: NoteUseCase(repository: NoteRepository(storage: UserDefaultsStorage())), iapService: IAPService()))
}
