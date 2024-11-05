//
//  HapticHelper.swift
//  aisle
//
//  Created by Varun Adit on 11/5/24.
//

import SwiftUI

/// Helper function to provide haptic feedback for buttons and onTapGesture.
///
/// - Parameters:
///     - style: The force feedback of the button press or onTapGesture.
///     - action: The action to be taken on button press or onTapGesture.
@MainActor
internal func withFeedback (
    _ style: UIImpactFeedbackGenerator.FeedbackStyle,
    _ action: @escaping () -> Void
) -> () -> Void {
    { () in
        let impact = UIImpactFeedbackGenerator(style: style)
        impact.prepare()
        impact.impactOccurred()
        action()
    }
}
