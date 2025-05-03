//
//  StorageProtocol.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/2/25.
//

import Foundation

protocol StorageProtocol {
    func save<T: Encodable>(_ items: [T], forKey key: String) throws
    func load<T: Decodable>(forKey key: String) throws -> [T]
}
