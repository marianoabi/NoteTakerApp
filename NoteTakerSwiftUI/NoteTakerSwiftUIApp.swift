//
//  NoteTakerSwiftUIApp.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/2/25.
//

import SwiftUI

@main
struct NoteTakerSwiftUIApp: App {
    // This environment object will help us track text size changes
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some Scene {
        WindowGroup {
            NoteListView(factory: ViewModelFactory(repository: NoteRepository(storage: UserDefaultsStorage())))
            // Force layout update when text size changes
                .id(dynamicTypeSize)
            // Ensure list adapts to dynamic type
                .environment(\.defaultMinListRowHeight,
                              dynamicTypeSize.isAccessibilitySize ? 80 : 44)
        }
    }
}
