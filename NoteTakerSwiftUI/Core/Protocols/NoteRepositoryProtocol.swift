//
//  NoteRepositoryProtocol.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/2/25.
//

import Foundation
import Combine

protocol NoteRepositoryProtocol {
    var notesPublisher: Published<[Note]>.Publisher { get }
    func getAllNotes() -> [Note]
    func addNote(_ note: Note)
    func searchNotes(searchText: String) -> [Note]
    func updateNote(_ note: Note)
    func deleteNote(withId id: UUID)
}
