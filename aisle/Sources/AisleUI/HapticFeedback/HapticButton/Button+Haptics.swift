//
//  Button+Haptics.swift
//  aisle
//
//  Created by Varun Adit on 11/5/24.
//

import SwiftUI

public extension Button {
    /// Extends the default SwiftUI button to provide haptic feedback.
    ///
    /// - Parameters:
    ///     - style: The force feedback of the button.
    ///     - action: The action to be taken on button press.
    ///     - label: The view to be presented as the button label.
    ///
    /// - Usage:
    /// ```
    /// Button(.soft) {
    ///     print("Button clicked")
    /// } label: {
    ///     Text("Haptic Button")
    /// }
    /// ```
    init(
        _ style: UIImpactFeedbackGenerator.FeedbackStyle,
        action: @escaping () -> Void,
        @ViewBuilder label: () -> Label
    ) {
        self.init(action: withFeedback(style, action), label: label)
    }
}


