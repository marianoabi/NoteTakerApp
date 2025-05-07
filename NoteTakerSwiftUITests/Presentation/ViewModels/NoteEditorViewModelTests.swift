//
//  NoteEditorViewModelTests.swift
//  NoteTakerSwiftUITests
//
//  Created by Abigail Mariano on 5/7/25.
//

import XCTest
@testable import NoteTakerSwiftUI

final class NoteEditorViewModelTests: XCTestCase {
    var sut: NoteEditorViewModel!
    var mockRepository: MockNoteRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockNoteRepository()
    }
    
    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testInitWithNewNote() {
        // When
        sut = NoteEditorViewModel(repository: mockRepository)
        
        // Then
        XCTAssertTrue(sut.isNewNote)
        XCTAssertEqual(sut.title, "")
        XCTAssertEqual(sut.content, "")
        XCTAssertEqual(sut.selectedColor, .blue)
    }
    
    func testInitWithExistingNote() {
        // Given
        let existingNote = Note(title: "Test Note", content: "Test Content", dateCreated: Date(), dateModified: Date(), color: .green)
        
        // When
        sut = NoteEditorViewModel(repository: mockRepository, note: existingNote)
        
        // Then
        XCTAssertFalse(sut.isNewNote)
        XCTAssertEqual(sut.title, "Test Note")
        XCTAssertEqual(sut.content, "Test Content")
        XCTAssertEqual(sut.selectedColor, .green)
    }
    
    func testSaveNewNote() {
        // Given
        sut = NoteEditorViewModel(repository: mockRepository)
        let initialCount = mockRepository.getAllNotes().count
        sut.title = "New Test Note"
        sut.content = "New Test Content"
        sut.selectedColor = .red
        
        // When
        sut.saveNote()
        
        // Then
        let notes = mockRepository.getAllNotes()
        XCTAssertEqual(notes.count, initialCount + 1)
        
        let savedNote = notes.first
        XCTAssertEqual(savedNote?.title, "New Test Note")
        XCTAssertEqual(savedNote?.content, "New Test Content")
        XCTAssertEqual(savedNote?.color, .red)
    }
    
    func testUpdateExistingNote() {
        // Given
        let specificNote = TestDataFactory.createTestNote(
            title: "Original Title",
            content: "Original Content",
            color: .blue
        )
        
        mockRepository.addNote(specificNote)
        sut = NoteEditorViewModel(repository: mockRepository, note: specificNote)
        
        // When
        sut.title = "Updated Title"
        sut.content = "Updated Content"
        sut.selectedColor = .purple
        sut.saveNote()
        
        // Then
        let updatedNote = mockRepository.getAllNotes().first { $0.id == specificNote.id }
        XCTAssertNotNil(updatedNote)
        XCTAssertEqual(updatedNote?.title, "Updated Title")
        XCTAssertEqual(updatedNote?.content, "Updated Content")
        XCTAssertEqual(updatedNote?.color, .purple)
    }
}
