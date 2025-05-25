//
//  CoreDataStorage.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/18/25.
//

import Foundation
import CoreData

class CoreDataStorage: StorageProtocol {
    private let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack = CoreDataStack.shared) {
        self.coreDataStack = coreDataStack
    }
    
    // MARK: - StorageProtocol
    
    func save<T>(_ items: [T], forKey key: String) throws where T : Encodable {
        guard let notes = items as? [Note] else {
            throw NSError(domain: "com.marianoabi.NoteTakerSwiftUI", code: 1001,
                          userInfo: [NSLocalizedDescriptionKey: "Cannot save items that are not Notes"])
        }
        
        let context = coreDataStack.viewContext
        
        // First, delete exisiting notes
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NoteEntity.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        try context.execute(batchDeleteRequest)
        
        // Insert new notes
        for note in notes {
            _ = NoteEntity.create(from: note, in: context)
        }
        
        coreDataStack.saveContext()
    }
    
    func load<T>(forKey key: String) throws -> [T] where T : Decodable {
        let context = coreDataStack.viewContext
        
        let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        // Sort by date modified (newest first)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "dateModified", ascending: false)]
        
        let entities = try context.fetch(fetchRequest)
        let notes = entities.compactMap { $0.toDomainModel() }
        
        if notes.isEmpty && key == "savedNotes" {
            return [] as! [T]
        }
        
        return notes as! [T]
    }
}
