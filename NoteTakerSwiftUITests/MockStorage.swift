//
//  MockStorage.swift
//  NoteTakerSwiftUITests
//
//  Created by Abigail Mariano on 5/7/25.
//

import Foundation
@testable import NoteTakerSwiftUI

class MockStorage: StorageProtocol {
    private var storage: [String: Data] = [:]

    func save<T>(_ items: [T], forKey key: String) throws where T : Encodable {
        let data = try JSONEncoder().encode(items)
        storage[key] = data
    }
    
    func load<T>(forKey key: String) throws -> [T] where T : Decodable {
        guard let data = storage[key] else {
            return []
        }
        return try JSONDecoder().decode([T].self, from: data)
    }
}
