//
//  Shimmer.swift
//  aisle
//
//  Created by Varun Adit on 11/5/24.
//

import SwiftUI

/// Adds a shimmering effect to any SwiftUI view, useful for loading placeholders or
/// indicating content is being fetched.
///
/// Usage:
/// ```swift
/// Capsule()
///     .shimmer()
/// ```
///
/// This extension adds a `shimmer()` modifier to all SwiftUI views, applying a `Shimmer`
/// effect that creates a smooth animated gradient. It’s commonly used to create a
/// loading state that visually suggests content is coming soon.
public extension View {
    /// Applies a shimmering effect on the view.
    ///
    /// - Returns: A view that displays with a shimmer animation.
    @ViewBuilder
    func shimmer() -> some View {
        self.modifier(Shimmer())
    }
}

/// A view modifier that creates a shimmering effect on views, often used as a loading indicator.
///
/// The shimmer effect animates a gradient that sweeps across the view, making it appear
/// as though light is moving over the surface. It typically uses opaque and semi-transparent
/// grays to give a subtle "loading" look.
///
/// Customize the colors and timing of the shimmer effect by adjusting the gradient and animation
/// settings in the modifier’s implementation if needed.
fileprivate struct Shimmer: ViewModifier {
    @State private var isInitialState = true

    public func body(content: Content) -> some View {
        content
            .mask(
                LinearGradient(
                    gradient: Gradient(colors: [.gray.opacity(0.9), .gray.opacity(0.2), .gray.opacity(0.9)]),
                    startPoint: isInitialState ? .init(x: -0.3, y: -0.3) : .init(x: 1, y: 1),
                    endPoint: isInitialState ? .init(x: 0, y: 0) : .init(x: 1.3, y: 1.3)
                )
            )
            .animation(
                .linear(duration: 2.5)
                    .delay(0.25)
                    .repeatForever(autoreverses: false),
                value: isInitialState
            )
            .onAppear {
                isInitialState = false
            }
    }
}
