//
//  NoteEntity+Helper.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/26/25.
//

import Foundation
import CoreData

extension NoteEntity {
    func update(from note: Note) {
        self.id = note.id
        self.title = note.title
        self.content = note.content
        self.dateCreated = note.dateCreated
        self.dateModified = note.dateModified
        self.colorName = note.color.rawValue
    }
    
    func toDomainModel() -> Note? {
        guard let id = self.id,
              let title = self.title,
              let content = self.content,
              let dateCreated = self.dateCreated,
              let dateModified = self.dateModified,
              let colorName = self.colorName,
              let color = NoteColor(rawValue: colorName) else {
            return nil
        }
        
        return Note(
            id: id,
            title: title,
            content: content,
            dateCreated: dateCreated,
            dateModified: dateModified,
            color: color
        )
    }
    
    static func create(from note: Note, in context: NSManagedObjectContext) -> NoteEntity {
        let entity = NoteEntity(context: context)
        entity.update(from: note)
        return entity
    }
}
