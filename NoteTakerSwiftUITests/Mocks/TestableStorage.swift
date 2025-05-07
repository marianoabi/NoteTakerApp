//
//  TestableStorage.swift
//  NoteTakerSwiftUITests
//
//  Created by Abigail Mariano on 5/7/25.
//

import Foundation
@testable import NoteTakerSwiftUI

class TestableStorage: StorageProtocol {
    private var storage: [String: Data] = [:]
    var savedItems: [String: Any] = [:] // For test verification
    var loadCalled = false
    var saveCalled = false
    
    func save<T>(_ items: [T], forKey key: String) throws where T : Encodable {
        saveCalled = true
        let data = try JSONEncoder().encode(items)
        storage[key] = data
        
        // Store for test verification
        savedItems[key] = items
    }
    
    func load<T>(forKey key: String) throws -> [T] where T : Decodable {
        loadCalled = true
        guard let data = storage[key] else { return [] }
        return try JSONDecoder().decode([T].self, from: data)
    }
    
    // Helper for test setup
    func preloadData<T: Encodable>(_ items: [T], forKey key: String) throws {
        let data = try JSONEncoder().encode(items)
        storage[key] = data
    }
}
