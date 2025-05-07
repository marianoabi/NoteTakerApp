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
        
        mockRepository = MockNoteRepository()
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
        // Given
        let expectation = XCTestExpectation(description: "Filtering notes")
        
        // When
        sut.searchText = "Project"
        
        // Then
        sut.$filteredNotes
            .dropFirst() // Skip initial value
            .sink { notes in
                XCTAssertEqual(notes.count, 1)
                XCTAssertEqual(notes.first?.title, "Project Ideas")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1.0)
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

