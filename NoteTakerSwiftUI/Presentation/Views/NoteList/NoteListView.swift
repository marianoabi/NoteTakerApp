//
//  NoteListView.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/2/25.
//

import SwiftUI

struct NoteListView: View {    	
    var body: some View {
        NavigationView {
            List {
                ForEach(1...10, id:\.self) {_ in
                    NoteRowView()
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Notes")
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "plus")
                    }
                }
            })
        }
    }
}

#Preview {
    NoteListView()
}
