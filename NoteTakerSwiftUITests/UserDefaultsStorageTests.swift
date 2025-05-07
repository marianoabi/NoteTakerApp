//
//  UserDefaultsStorageTests.swift
//  NoteTakerSwiftUITests
//
//  Created by Abigail Mariano on 5/7/25.
//

import XCTest
@testable import NoteTakerSwiftUI

final class UserDefaultsStorageTests: XCTest {
    var sut: UserDefaultsStorage!
    let testKey = "testStorageKey"
    
    override func setUp() {
        super.setUp()
        sut = UserDefaultsStorage()
        
        UserDefaults.standard.removeObject(forKey: testKey)
    }
    
    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: testKey)
        sut = nil
        super.tearDown()
    }
    
    func testSaveAndLoadData() throws {
        // Given
        let notesToSave = [
            Note(title: "Test Note 1", content: "Content 1", dateCreated: Date(), dateModified: Date()),
            Note(title: "Test Note 2", content: "Content 2", dateCreated: Date(), dateModified: Date())
        ]
        
        // When
        try sut.save(notesToSave, forKey: testKey)
        let loadedNotes: [Note] = try sut.load(forKey: testKey)
        
        // Then
        XCTAssertEqual(loadedNotes.count, notesToSave.count)
        XCTAssertEqual(loadedNotes[0].id, notesToSave[0].id)
        XCTAssertEqual(loadedNotes[0].title, notesToSave[0].title)
        XCTAssertEqual(loadedNotes[1].id, notesToSave[1].id)
        XCTAssertEqual(loadedNotes[1].title, notesToSave[1].title)
    }
    
    func testLoadEmptyData() throws {
        // When
        let loadedNotes: [Note] = try sut.load(forKey: "nonExistentKey")
        
        // Then
        XCTAssertTrue(loadedNotes.isEmpty)
    }
}
