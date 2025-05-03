//
//  Note.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/2/25.
//

import Foundation

struct Note: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    var content: String
    var dateCreated: Date
    var dateModified: Date
    var color: NoteColor
    
    init(id: UUID = UUID(), title: String, content: String, dateCreated: Date, dateModified: Date, color: NoteColor = .blue) {
        self.id = id
        self.title = title
        self.content = content
        self.dateCreated = dateCreated
        self.dateModified = dateModified
        self.color = color
    }
}
