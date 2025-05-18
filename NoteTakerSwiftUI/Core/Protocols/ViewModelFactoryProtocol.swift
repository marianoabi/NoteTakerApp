//
//  ViewModelFactoryProtocol.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/4/25.
//

import Foundation

protocol ViewModelFactoryProtocol {
    func makeNoteListViewModel() -> NoteListViewModel
    func makeNoteEditorViewModel(note: Note?) -> NoteEditorViewModel
    func makeDateFormatterService() -> DateFormatterServiceProtocol
}
