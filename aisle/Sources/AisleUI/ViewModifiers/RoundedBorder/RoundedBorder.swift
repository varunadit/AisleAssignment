//
//  RoundedBorder.swift
//  aisle
//
//  Created by Varun Adit on 11/6/24.
//

import SwiftUI

/// A custom view modifier for styling phone input fields
public struct RoundedBorder: ViewModifier {
    public var width: CGFloat?
    
    public init(width: CGFloat? = nil) {
        self.width = width
    }
    
    public func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .padding(.vertical, 12)
            .overlay (
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(red: 196/255, green: 196/255, blue: 196/255), lineWidth: 2)
            )
    }
}
