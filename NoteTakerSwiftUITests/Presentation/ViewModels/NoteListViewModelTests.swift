//
//  NoteListViewModelTests.swift
//  NoteTakerSwiftUITests
//
//  Created by Abigail Mariano on 5/7/25.
//

import XCTest
import Combine
@testable import NoteTakerSwiftUI

final class NoteListViewModelTests: XCTestCase {
    var sut: NoteListViewModel!
    var mockRepository: MockNoteRepository!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        
        let testNotes = [
            TestDataFactory.createTestNote(title: "Project Alpha", content: "Details about Project Alpha"),
            TestDataFactory.createTestNote(title: "Meeting Notes", content: "Project Beta discussion"),
            TestDataFactory.createTestNote(title: "Shopping List", content: "Items to buy")
        ]
        
        mockRepository = MockNoteRepository(initialNotes: testNotes)
        sut = NoteListViewModel(repository: mockRepository)
        cancellables = []
    }
    
    override func tearDown() {
        sut = nil
        mockRepository = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testInitialState() {
        // Then
        XCTAssertEqual(sut.filteredNotes.count, mockRepository.getAllNotes().count)
        XCTAssertEqual(sut.searchText, "")
    }
    
    func testFilteringWithSearchText() {
        // Given - Known test data with "Project" in the title and content
        
        // When
        sut.searchText = "Project"
        
        // Force a small delay to allow the Combine pipeline to process
        let expectation = XCTestExpectation(description: "Filtering notes")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
        // Then - we know exactly which notes should match
        XCTAssertEqual(sut.filteredNotes.count, 2)
        XCTAssertTrue(sut.filteredNotes.contains(where: { $0.title == "Project Alpha" }))
        XCTAssertTrue(sut.filteredNotes.contains(where: { $0.content.contains("Project Beta") }))
    }
    
    func testDeleteNote() {
        // Given
        guard let noteToDelete = sut.filteredNotes.first else {
            XCTFail("No notes available to delete")
            return
        }
        
        let initialCount = sut.filteredNotes.count
        
        // When
        sut.deleteNote(at: 0) // Delete first note
        
        // Then
        
        XCTAssertEqual(sut.filteredNotes.count, initialCount - 1)
        XCTAssertFalse(sut.filteredNotes.contains { $0.id == noteToDelete.id })
    }
}

