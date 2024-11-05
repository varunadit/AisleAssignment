//
//  RoundedCornerModifier.swift
//  aisle
//
//  Created by Varun Adit on 11/5/24.
//

import SwiftUI

/// A view modifier that applies rounded corners to specific corners of a view with an optional stroke.
///
/// - Parameters:
///     - radius: The radius of the rounded corners.
///     - corners: The corners to be rounded (UIRectCorner).
///     - strokeColor: The color of the stroke around the rounded corners.
///     - lineWidth: The width of the stroke line (0.0 means no stroke).
public struct RoundedCornerModifier: ViewModifier {
    let radius: CGFloat
    let corners: UIRectCorner
    let strokeColor: Color
    let lineWidth: CGFloat
        
    /// Applies the rounded corner modification to the content.
    ///
    /// - Parameter content: The view to be modified.
    /// - Returns: A view with the specified corners rounded and optional stroke applied.
    public func body(content: Content) -> some View {
        content
            .clipShape(
                RoundedCorner(radius: radius, corners: corners)
            )
            .overlay(
                RoundedCorner(radius: radius, corners: corners)
                    .stroke(strokeColor, lineWidth: lineWidth)
            )
    }
}

/// A custom shape that creates rounded corners on specified corners of a rectangle.
///
/// - Parameters:
///     - radius: The radius of the rounded corners.
///     - corners: The corners to be rounded (UIRectCorner).
public struct RoundedCorner: Shape {
    public var radius: CGFloat
    public var corners: UIRectCorner
    
    /// Creates the path for the rounded corner shape.
    ///
    /// - Parameters:
    ///     - rect: The rectangle in which to draw the rounded corner shape.
    /// - Returns: A Path representing the shape with rounded corners.
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    /// Applies rounded corners to specific corners of a view with an optional stroke.
    ///
    /// Example usage:
    /// ```swift
    /// Rectangle()
    ///     .roundedCorners(radius: 10, corners: [.topLeft, .topRight], strokeColor: .blue, lineWidth: 2)
    /// ```
    ///
    /// - Parameters:
    ///     - radius: The radius of the rounded corners.
    ///     - corners: The corners to be rounded (defaults to all corners).
    ///     - strokeColor: The color of the stroke around the rounded corners (defaults to primary).
    ///     - lineWidth: The width of the stroke line (defaults to 0.0, meaning no stroke).
    /// - Returns: A view with the specified corners rounded and optional stroke applied.
    public func roundedCorners(
        radius: CGFloat,
        corners: UIRectCorner = .allCorners,
        strokeColor: Color = Color.primary,
        lineWidth: CGFloat = 0.0
    ) -> some View {
        self.modifier(RoundedCornerModifier(radius: radius, corners: corners, strokeColor: strokeColor, lineWidth: lineWidth))
    }
}
