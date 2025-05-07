//
//  NoteRepositoryTests.swift
//  NoteTakerSwiftUITests
//
//  Created by Abigail Mariano on 5/7/25.
//

import XCTest
@testable import NoteTakerSwiftUI

final class NoteRepositoryTests: XCTestCase {
    var sut: NoteRepository!
    var mockStorage: MockStorage!
    
    override func setUp() {
        super.setUp()
        mockStorage = MockStorage()
        sut = NoteRepository(storage: mockStorage)
    }
    
    override func tearDown() {
        sut = nil
        mockStorage = nil
        super.tearDown()
    }
    
    func testAddNote() {
        // Given
        let newNote = Note(title: "Test Note", content: "Test Content", dateCreated: Date(), dateModified: Date())
        
        // When
        sut.addNote(newNote)
        
        // Then
        XCTAssertEqual(sut.getAllNotes().count, 4)
        XCTAssertEqual(sut.getAllNotes()[0].id, newNote.id)
    }
    
    func testUpdateNote() {
        // Given
        let initialNotes = sut.getAllNotes()
        guard let noteToUpdate = initialNotes.first else {
            XCTFail("No notes available to update")
            return
        }
        
        // When
        var updatedNote = noteToUpdate
        updatedNote.title = "Updated Title"
        updatedNote.content = "Updated Content"
        sut.updateNote(updatedNote)
        
        // Then
        let retrievedNote = sut.getAllNotes().first { $0.id == noteToUpdate.id }
        XCTAssertNotNil(retrievedNote)
        XCTAssertEqual(retrievedNote?.title, updatedNote.title)
        XCTAssertEqual(retrievedNote?.content, updatedNote.content)
    }
    
    func testDeleteNote() {
        // Given
        
        let initialNotes = sut.getAllNotes()
        guard let noteToDelete = initialNotes.first else {
            XCTFail("No notes available to delete")
            return
        }
        
        let initialCount = initialNotes.count
        
        // When
        sut.deleteNote(withId: noteToDelete.id)
        
        // Then
        let finalNotes = sut.getAllNotes()
        XCTAssertEqual(finalNotes.count, initialCount - 1)
        XCTAssertNil(finalNotes.first { $0.id == noteToDelete.id })
    }
    
    func testSearchNotes() {
        // Given
        let searchText = sut.getAllNotes().first?.title ?? "Welcome"
        
        // When
        let searchResults = sut.searchNotes(searchText: searchText)
        
        // Then
        XCTAssertFalse(searchResults.isEmpty)
        XCTAssertTrue(searchResults.allSatisfy {
            $0.title.localizedCaseInsensitiveContains(searchText)
        })
    }
}
