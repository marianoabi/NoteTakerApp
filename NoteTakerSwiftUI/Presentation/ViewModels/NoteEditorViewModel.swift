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
    
    private let useCase: NoteUseCaseProtocol
    private let iapService: IAPServiceProtocol
    private let noteId: UUID?
    private let dateCreated: Date
    private var cancellables = Set<AnyCancellable>()
    
    var isNewNote: Bool {
        return noteId == nil
    }
    
    init(useCase: NoteUseCaseProtocol, iapService: IAPServiceProtocol, note: Note? = nil) {
        self.useCase = useCase
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
            _ = useCase.addNote(title: title, content: content, color: selectedColor)
        } else if let id = noteId {
            useCase.updateNote(id: id,title: title, content: content, color: selectedColor)
        }
    }
}
