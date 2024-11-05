//
//  HapticTapGestureViewModifier.swift
//  aisle
//
//  Created by Varun Adit on 11/5/24.
//

import SwiftUI

/// Helper to extend the default SwiftUI onTapGesture to provide haptic feedback.
///
/// - Parameters:
///     - style: The force feedback of the button.
///     - action: The action to be taken on button press.
internal struct HapticTapGestureViewModifier: ViewModifier {
    var style: UIImpactFeedbackGenerator.FeedbackStyle
    var action: () -> Void
    
    func body(content: Content) -> some View {
        content.onTapGesture(perform: withFeedback(self.style, self.action))
    }
}

extension View {
    /// Extends the default SwiftUI onTapGesture to provide haptic feedback.
    ///
    /// - Parameters:
    ///     - style: The force feedback of the button.
    ///     - perform: The action to be taken on button press.
    func onTapGesture (
        _ style: UIImpactFeedbackGenerator.FeedbackStyle,
        perform action: @escaping () -> Void
    ) -> some View {
        modifier(HapticTapGestureViewModifier(style: style, action: action))
    }
}
