//
//  AnimatedGlassBackground.swift
//  NoteTakerSwiftUI
//
//  Created by Abigail Mariano on 6/24/25.
//

import SwiftUI

struct AnimatedGlassBackground: View {
    @State private var phase = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(
                    colors: [
                        Color.blue.opacity(0.1),
                        Color.purple.opacity(0.1),
                        Color.cyan.opacity(0.1)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                ForEach(0..<3, id: \.self) { index in
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    Color.white.opacity(0.3),
                                    Color.clear
                                ],
                                center: .center,
                                startRadius: 10,
                                endRadius: 50
                            )
                        )
                        .frame(width: 100, height: 100)
                        .offset(
                            x: cos(phase + Double(index) * 2) * 50,
                            y: sin(phase + Double(index) * 3) * 30
                        )
                        .blur(radius: 1)
                }
                
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .opacity(0.1)
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                phase = .pi * 2
            }
        }
    }
}

struct GlassNavigationBackground: View {
    var body: some View {
        Rectangle()
            .fill(.regularMaterial)
            .opacity(0.8)
            .overlay(
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.1),
                                Color.clear
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            )
    }
}
