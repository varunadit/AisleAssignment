//
//  AislePrimaryButtonStyle.swift
//  aisle
//
//  Created by Varun Adit on 11/5/24.
//

import SwiftUI
/// A custom button style that provides a primary look for buttons within the app.
///
/// The `AislePrimaryButtonStyle` style applies consistent padding, foreground color,
/// background color, and shape to buttons, giving them a capsule appearance.
/// It also adjusts saturation based on the button's enabled state, graying out when disabled.
///
/// Usage:
/// ```swift
/// Button("Click me") {
///     print("Button clicked")
/// }
/// .buttonStyle(.aislePrimary)
/// ```
public struct AislePrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.black)
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(Color.aisleDemoButton)
            .clipShape(Capsule(style: .circular))
            .saturation(isEnabled ? 1 : 0) // Grays out if button is disabled
            .opacity(configuration.isPressed ? 0.5 : 1)
            .scaleEffect(configuration.isPressed ? 0.96 : 1)

    }
}

public extension ButtonStyle where Self == AislePrimaryButtonStyle {
    /// A shortcut for applying the primary button style used in the Aisle app.
    ///
    /// This provides a standard style that can be consistently reused in the Aisle app.
    /// Example:
    /// ```swift
    /// Button("Click me") {
    ///     print("Button clicked")
    /// }
    /// .buttonStyle(.aislePrimary)
    /// ```
    static var aislePrimary: AislePrimaryButtonStyle {
        AislePrimaryButtonStyle()
    }
}

/// Provides a preview of the AislePrimaryButtonStyle, demonstrating its usage
/// within a vertically-centered button.
///
/// This preview showcases the button’s appearance and interaction in isolation.
#Preview {
    VStack {
        Spacer()
        
        Button {
            print("Button clicked")
        } label: {
            Text("Click me")
                .fontWeight(.bold)
        }
        .buttonStyle(.aislePrimary)

        Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.aisleDemoBackground)
}
