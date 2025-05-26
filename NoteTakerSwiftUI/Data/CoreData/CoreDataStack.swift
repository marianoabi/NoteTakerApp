//
//  CoreDataStack.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/26/25.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    deinit {
        print(StringConstants.App.dealloc.formatted(with: String(describing: Self.self)))
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: StringConstants.App.coreDataModel)
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError(StringConstants.Error.CoreData.loadCoreDataStackFailed.formatted(with: error.localizedDescription))
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as NSError
                print(StringConstants.Error.CoreData.unresolved.formatted(with: error, error.userInfo))
            }
        }
    }
}
