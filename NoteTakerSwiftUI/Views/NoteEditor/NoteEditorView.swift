//
//  NoteEditorView.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/2/25.
//


import SwiftUI

struct NoteEditorView: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Note title", text: .constant(""))
                }
                
                Section(header: Text("Content")) {
                    TextField("Note content", text: .constant(""))
                        .frame(minHeight: 200)
                }
                
                Section(header: Text("Color")) {
                    ColorPickerView()
                }
            }
            .navigationTitle("New Note")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        
                    }
                    .disabled(true)
                }
            }
        }
    }
}

#Preview {
    NoteEditorView()
}
