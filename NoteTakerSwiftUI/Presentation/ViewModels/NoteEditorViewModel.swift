//
//  NoteEditorViewModel.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/4/25.
//

import Foundation
import Combine

class NoteEditorViewModel: ObservableObject {
    @Published var title: String
    @Published var content: String
    @Published var selectedColor: NoteColor
    @Published var isPremiumUser: Bool = false
    
    private let repository: NoteRepositoryProtocol
    private let iapService: IAPServiceProtocol
    private let noteId: UUID?
    private let dateCreated: Date
    private var cancellables = Set<AnyCancellable>()
    
    var isNewNote: Bool {
        return noteId == nil
    }
    
    init(repository: NoteRepositoryProtocol, iapService: IAPServiceProtocol, note: Note? = nil) {
        self.repository = repository
        self.iapService = iapService
        self.title = note?.title ?? ""
        self.content = note?.content ?? ""
        self.selectedColor = note?.color ?? .blue
        self.noteId = note?.id
        self.dateCreated = note?.dateCreated ?? Date()
        
        isPremiumUser = iapService.isPurchased(PremiumFeature.productID)
        
        iapService.purchasedProductsPublisher
            .map { $0.contains(PremiumFeature.productID) }
            .assign(to: \.isPremiumUser, on: self)
            .store(in: &cancellables)
    }
    
    func saveNote() {
        if selectedColor.isPremium && !isPremiumUser {
            selectedColor = .blue
        }
        
        if isNewNote {
            let newNote = Note(title: title, content: content, dateCreated: Date(), dateModified: Date(), color: selectedColor)
            repository.addNote(newNote)
        } else if let id = noteId {
            let updateNote = Note(id: id,title: title, content: content, dateCreated: dateCreated, dateModified: Date(), color: selectedColor)
            repository.updateNote(updateNote)
        }
    }
}
