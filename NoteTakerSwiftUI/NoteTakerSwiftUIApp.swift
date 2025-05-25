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
    
    let factory = ViewModelFactory(
        repository: NoteRepository(storage: CoreDataStorage(), ),
        iapService: IAPService()
    )
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NoteListView(factory: factory)
                    .id(dynamicTypeSize)
                    .environment(
                        \.defaultMinListRowHeight,
                         dynamicTypeSize.isAccessibilitySize ? 80 : 44
                    )
                    .tabItem {
                        Label("Notes", systemImage: "note.text")
                    }
                
                StoreView(factory: factory)
                    .tabItem {
                        Label("Store", systemImage: "bag")
                    }
            }
            .environment(\.managedObjectContext, CoreDataStack.shared.viewContext)
        }
    }
}
