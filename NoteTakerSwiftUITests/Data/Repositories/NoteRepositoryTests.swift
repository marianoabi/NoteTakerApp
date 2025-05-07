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
    var testableStorage: TestableStorage!
    let storageKey = "savedNotes"
    
    override func setUp() {
        super.setUp()
        testableStorage = TestableStorage()
        sut = NoteRepository(storage: testableStorage)
    }
    
    override func tearDown() {
        sut = nil
        testableStorage = nil
        super.tearDown()
    }
    
    func testLoadNotesCallsStoreageLoad() {
        // Then - verify the storage load was called during repository initialization
        XCTAssertTrue(testableStorage.loadCalled)
    }
    
    func testAddNoteSavesCalls() {
        // Given
        testableStorage.saveCalled = false // Reset the flag
        let newNote = TestDataFactory.createTestNote(title: "New Test Note")
        
        // When
        sut.addNote(newNote)
        
        // Then
        XCTAssertTrue(testableStorage.saveCalled, "Save should be called when adding a note")
    }
    
    func testUpdateNoteSavesCalls() {
        // Given
        // Preload data to ensure we have a note to update
        let testNote = TestDataFactory.createTestNote()
        try? testableStorage.preloadData([testNote], forKey: storageKey)
        
        // Create a new repository instance to load the preloaded data
        sut = NoteRepository(storage: testableStorage)
        
        // Reset the flag after initialization
        testableStorage.saveCalled = false
        
        // Create an updated version of the note
        var updatedNote = testNote
        updatedNote.title = "Updated Title"
        
        // When
        sut.updateNote(updatedNote)
        
        // Then
        XCTAssertTrue(testableStorage.saveCalled, "Save should be called when updating a note")
    }
    
    func testDeleteNoteSavesCalls() {
        // Given
        // Preload data to ensure we have a note to delete
        let testNote = TestDataFactory.createTestNote()
        try? testableStorage.preloadData([testNote], forKey: storageKey)
        
        // Create a new repository instance to load the preloaded data
        sut = NoteRepository(storage: testableStorage)
        
        // Reset the flag after initialization
        testableStorage.saveCalled = false
        
        // When
        sut.deleteNote(withId: testNote.id)
        
        // Then
        XCTAssertTrue(testableStorage.saveCalled, "Save should be called when deleting a note")
    }
    
    func testRepositoryPersistsDataCorrectly() {
        // Given
        let testNote = TestDataFactory.createTestNote(title: "Test Persistence")
        
        // When
        sut.addNote(testNote)
        
        // Then
        let savedNotes = testableStorage.savedItems[storageKey] as? [Note]
        XCTAssertNotNil(savedNotes)
        XCTAssertTrue(savedNotes?.contains { $0.id == testNote.id } ?? false)
    }
    
    func testSearchNotesWithMatchingText() {
        // Given
        let notes = [
            TestDataFactory.createTestNote(title: "Alpha Project", content: "First project"),
            TestDataFactory.createTestNote(title: "Beta Testing", content: "Second project"),
            TestDataFactory.createTestNote(title: "Gamma Release", content: "Third milestone")
        ]
        
        try? testableStorage.preloadData(notes, forKey: storageKey)
        
        sut = NoteRepository(storage: testableStorage)
        
        // When
        let results = sut.searchNotes(searchText: "project")
        
        // Then
        XCTAssertEqual(results.count, 2)
        XCTAssertTrue(results.contains(where: { $0.title == "Alpha Project" }))
        XCTAssertTrue(results.contains(where: { $0.title == "Beta Testing" }))
    }
    
    func testSearcgNotesWithNonMatchingText() {
        // Given
        // Preload with notes that won't match the search
        let notes = [
            TestDataFactory.createTestNote(title: "Alpha", content: "First"),
            TestDataFactory.createTestNote(title: "Beta", content: "Second"),
        ]
        try? testableStorage.preloadData(notes, forKey: storageKey)
        
        // Create a new repository instance to load the preloaded data
        sut = NoteRepository(storage: testableStorage)
        
        // When
        let results = sut.searchNotes(searchText: "nonexistent")
        
        // Then
        XCTAssertTrue(results.isEmpty)
    }
}
