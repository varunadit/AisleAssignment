//
//  Shimmer.swift
//  aisle
//
//  Created by Varun Adit on 11/5/24.
//

import SwiftUI

/// Extends default SwiftUI views to apply a shimmering effect on the view.
public extension View {
    @ViewBuilder
    func shimmer() -> some View {
        self.modifier(Shimmer())
    }
}

/// Applies a shimmer effect to Views.
/// Primarily used on loading screens
public struct Shimmer: ViewModifier {
    @State private var isInitialState = true
    
    public func body(content: Content) -> some View {
        content
            .mask(
                LinearGradient(
                    gradient: .init(colors: [.gray.opacity(0.9), .gray.opacity(0.2), .gray.opacity(0.9)]),
                    startPoint: (isInitialState ? .init(x: -0.3, y: -0.3) : .init(x: 1, y: 1)),
                    endPoint: (isInitialState ? .init(x: 0, y: 0) : .init(x: 1.3, y: 1.3))
                )
            )
            .animation(.linear(duration: 2.5).delay(0.25).repeatForever(autoreverses: false), value: isInitialState)
            .onAppear {
                isInitialState = false
            }
    }
}
