//
//  GlassEffect.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 6/24/25.
//

import Foundation
import SwiftUI

struct GlassEffect: ViewModifier {
    let opacity: Double
    let blur: CGFloat
    let brightness: Double
    
    init(opacity: Double = 0.1, blur: CGFloat = 10, brightness: Double = 1.1) {
        self.opacity = opacity
        self.blur = blur
        self.brightness = brightness
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .opacity(opacity)
                    .blur(radius: blur / 2)
                    .brightness(brightness)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.3),
                                Color.clear,
                                Color.black.opacity(0.1)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
            .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct LiquidGlassCard: ViewModifier {
    let cornerRadius: CGFloat
    let shadowRadius: CGFloat
    
    init(cornerRadius: CGFloat = 20, shadowRadius: CGFloat = 15) {
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.ultraThinMaterial)
                        .opacity(0.8)
                    
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.2),
                                    Color.clear,
                                    Color.black.opacity(0.05)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.6),
                                Color.white.opacity(0.1),
                                Color.clear
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1.5
                    )
            )
            .shadow(
                color: Color.black.opacity(0.1),
                radius: shadowRadius,
                x: 0,
                y: shadowRadius / 2
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

extension View {
    func glassEffect(opacity: Double = 0.1, blur: CGFloat = 10, brightness: Double = 1.1) -> some View {
        self.modifier(GlassEffect(opacity: opacity, blur: blur, brightness: brightness))
    }
    
    func liquidGlass(cornerRadius: CGFloat = 20, shadowRadius: CGFloat = 15) -> some View {
        self.modifier(LiquidGlassCard(cornerRadius: cornerRadius, shadowRadius: shadowRadius))
    }
}
