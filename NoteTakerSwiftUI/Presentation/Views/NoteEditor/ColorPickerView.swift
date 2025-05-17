//
//  ColorPickerView.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 5/2/25.
//
import SwiftUI

struct ColorPickerView: View {
    @Binding var selectedColor: NoteColor
    let isPremiumUser: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Standard Colors")
                .font(.caption)
                .foregroundStyle(Color.secondary)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(NoteColor.basicColors, id: \.self) { color in
                        Circle()
                            .fill(color.color)
                            .frame(width: 30, height: 30)
                            .overlay(
                                Circle()
                                    .stroke(Color.primary, lineWidth: selectedColor == color ? 2 : 0)
                                    .padding(2)
                            )
                            .onTapGesture(perform: { selectedColor = color })
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel(ColorPickerAccessibilityHelper.containerLabel())
                            .accessibilityAddTraits(selectedColor == color ? .isSelected : [])
                            .accessibilityHint(ColorPickerAccessibilityHelper.colorHint())
                    }
                }
            }
            .accessibilityLabel("Color selector")
            
            Divider()
                .padding(.vertical, 8)
            
            HStack {
                Text("Premium Colors")
                    .font(.caption)
                    .foregroundStyle(Color.secondary)
                
                if !isPremiumUser {
                    Spacer()
                    
                    NavigationLink(destination: StorePlaceholderView()) {
                        Label("Unlock", systemImage: "lock")
                            .font(.caption)
                            .foregroundStyle(Color.blue)
                    }
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(NoteColor.premiumColors, id: \.self) { color in
                        Circle()
                            .fill(color.color)
                            .frame(width: 30, height: 30)
                            .overlay(
                                Circle()
                                    .stroke(Color.primary, lineWidth: selectedColor == color ? 2 : 0)
                                    .padding(2)
                            )
                            .overlay(
                                Image(systemName: "lock.fill")
                                    .foregroundStyle(Color.white)
                                    .opacity(isPremiumUser ? 0 : 0.7)
                            )
                            .onTapGesture {
                                if isPremiumUser {
                                    selectedColor = color
                                }
                            }
                            .opacity(isPremiumUser ? 1.0 : 0.6)
                    }
                }
            }
        }
    }
}

struct StorePlaceholderView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "lock.open")
                .font(.system(size: 60))
                .foregroundStyle(Color.blue)
            
            Text("Premium Feature")
                .font(.title)
                .fontWeight(.bold)
            
                Text("This feature requires premium subscription. Please go to the Store tab to purchase premium.")
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Close") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .background(Color.blue)
            .foregroundStyle(Color.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var selectedColor: NoteColor = .yellow
    
    VStack {
        ColorPickerView(selectedColor: $selectedColor, isPremiumUser: false)
        ColorPickerView(selectedColor: $selectedColor, isPremiumUser: true)
    }
    .padding()}
