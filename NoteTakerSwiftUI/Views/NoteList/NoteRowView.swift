//
//  NoteRowView.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/2/25.
//

import SwiftUI

struct NoteRowView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Hello Jaden")
                .font(.headline)
                .lineLimit(1)
            
            Text("Mommy is cooking dinner")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)
            
            HStack {
                Text("May 2, 2025")
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                Spacer()
                
                Circle()
                    .fill(.blue)
                    .frame(width: 12, height: 12)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NoteRowView()
}
