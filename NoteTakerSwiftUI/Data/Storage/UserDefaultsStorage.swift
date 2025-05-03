//
//  UserDefaultsStorage.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/2/25.
//

import Foundation

struct UserDefaultsStorage: StorageProtocol {
    private let userDefaults = UserDefaults.standard
    
    func save<T>(_ items: [T], forKey key: String) throws where T : Encodable {
        let data = try JSONEncoder().encode(items)
        userDefaults.set(data, forKey: key)
    }
    
    func load<T>(forKey key: String) throws -> [T] where T : Decodable {
        guard let data = userDefaults.data(forKey: key) else { return [] }
        
        return try JSONDecoder().decode([T].self, from: data)
    }
}
