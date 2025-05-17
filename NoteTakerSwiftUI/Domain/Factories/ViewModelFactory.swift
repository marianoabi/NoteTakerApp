//
//  ViewModelFactory.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/4/25.
//

import Foundation

class ViewModelFactory: ViewModelFactoryProtocol {
    private let repository: NoteRepositoryProtocol
    private let iapService: IAPServiceProtocol
    
    init(repository: NoteRepositoryProtocol? = nil, iapService: IAPServiceProtocol? = nil) {
        if let repo = repository {
            self.repository = repo
        } else {
            self.repository = NoteRepository(storage: UserDefaultsStorage())
        }
        
        if let service = iapService {
            self.iapService = service
        } else {
            self.iapService = IAPService()
        }
    }
    
    func makeNoteListViewModel() -> NoteListViewModel {
        return NoteListViewModel(repository: repository)
    }
    
    func makeNoteEditorViewModel(note: Note?) -> NoteEditorViewModel {
        return NoteEditorViewModel(repository: repository, iapService: iapService, note: note)
    }
    
    func makeDateFormatterService() -> DateFormatterServiceProtocol {
        return DateFormatterService()
    }
    
    func makeIAPService() -> IAPServiceProtocol {
        return iapService
    }
    
    func makeStoreViewModel() -> StoreViewModel {
        return StoreViewModel(iapService: iapService)
    }
}
