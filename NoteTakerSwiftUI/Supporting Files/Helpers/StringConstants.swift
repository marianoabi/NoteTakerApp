//
//  StringConstants.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/26/25.
//

import Foundation

struct StringConstants {
    // MARK: - App
    struct App {
        static let bundleID = "com.marianoabi.NoteTakerSwiftUI"
        static let coreDataModel = "NoteTakerModel"
        static let dealloc = "%@ deallocated"
    }
    
    // MARK: - Storage Keys
    struct StorageKeys {
        static let savedNotes = "savedNotes"
    }
    
    // MARK: - Tabs
    struct Tab {
        static let firstTab = "Notes"
        static let secondTab = "Store"
    }
    
    // MARK: - UI Text
    struct UI {
        static let appTitle = Tab.firstTab
        static let newNote = "New Note"
        static let searchNote = "Search Note"
        static let editNote = "Edit Note"
        static let cancel = "Cancel"
        static let save = "Save"
        static let title = "Title"
        static let content = "Content"
        static let color = "Color"
        static let standardColors = "Standard Colors"
        static let premiumColors = "Premium Colors"
        static let unlock = "Unlock"
        static let noteTitle = "Note title"
//        static let noteContent = "Note content"
    }
    
    // MARK: - Accessibility Text
    struct Accessibility {
        static let colorSelector = "Color selector"
        static let colorHint = "Double tap to select this color for your note"
        static let noteTitle = "Note Title"
        static let noteTitleHint = "Enter the title for your note"
        static let noteContent = "Note content"
        static let noteContentHint = "Enter the content for your note"
        static let createNewNote = "Create new note"
        static let noteTapHint = "Double tap to edit this note"
        static let noteColor = "Note color"
        static let noteColorHint = "Select a color for your note"
        static let cancel = UI.cancel
        static let cancelHint = "Discard changes and return to notes list"
        static let saveNote = "Save note"
        static let disabledButton = "Button is disabled, add a title to enable"
        static let saveNoteLong = "Save your note and return to notes list"
    }
    
    // MARK: - Store Text
    struct Store {
        static let navigationTitle = Tab.secondTab
        static let title = "Premium Features"
        static let subtitle = "Enhance your note-taking experience"
        static let subtitle2 = "Unlock all premium features"
        static let buyFormat = "Buy for %@"
        static let purchased = "Purchased"
        static let restorePurchases = "Restore Purchases"
        static let noProducts = "No products available"
    }
    
    // MARK: - Product IDs
    struct ProductIDs {
        static let premiumMonthly = "com.marianoabi.NoteTakerSwiftUI.premium.monthly"
    }
    
    // MARK: - Sample Notes
    struct SampleNotes {
        static let welcomeTitle = "Welcome to Notes App"
        static let welcomeContent = "This is a sample note to help you get started. Swipe left to delete or tap to edit"
        
        static let shoppingTitle = "Shopping List"
        static let shoppingContent = "- Milk\n- Eggs\n- Bread\n- Butter"
        
        static let projectTitle = "Project Ideas"
        static let projectContent = "1. Learn SwiftUI\n2. Build portfolio app\n3. Update resumè"
    }
    
    struct Error {
        static let saveNotes = "Cannot save items that are not Notes"
        static let transactionFailed = "Transaction failed verification: %@"
        static let verficationFailed = "Failed to verify transaction: %@"
        
        struct CoreData {
            static let loadCoreDataStackFailed = "Failed to load Core Data stack: %@"
            static let unresolved = "Unresolved Core Data error: %@, %@"
        }
    }
}
