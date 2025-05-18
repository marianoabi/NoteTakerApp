//
//  NoteUseCaseProtocol.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/18/25.
//

import Foundation
import Combine

protocol NoteUseCaseProtocol {
    var notesPublisher: Published<[Note]>.Publisher { get }
    func getAllNotes() -> [Note]
    func addNote(title: String, content: String, color: NoteColor) -> Note
    func updateNote(id: UUID, title: String, content: String, color: NoteColor)
    func deleteNote(withId id: UUID)
    func searchNotes(searchText: String) -> [Note]
}
