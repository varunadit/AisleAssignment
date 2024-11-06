//
//  OutlinedTextFieldStyle.swift
//  aisle
//
//  Created by Varun Adit on 11/6/24.
//

import SwiftUI

public struct OutlinedTextFieldStyle: TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color(red: 196/255, green: 196/255, blue: 196/255), lineWidth: 2)
            }
    }
}

public extension TextFieldStyle where Self == OutlinedTextFieldStyle {
    /// A shortcut for applying text field style used in the Aisle app.
    ///
    /// This provides a standard style that can be consistently reused in the Aisle app.
    /// Example:
    /// ```
    /// Button("Click me") {
    ///     print("Button clicked")
    /// }
    /// .buttonStyle(.aislePrimary)
    /// ```
    static var aisleTextField: OutlinedTextFieldStyle {
        OutlinedTextFieldStyle()
    }
}

/// Provides a preview of the AislePrimaryButtonStyle, demonstrating its usage
/// within a vertically-centered button.
///
/// This preview showcases the button’s appearance and interaction in isolation.
#Preview {
    OutlineTextFieldPreview()
}

struct OutlineTextFieldPreview: View {
    @State var text: String = ""
    var body: some View {
        VStack {
            Spacer()
            HStack {
                TextField("Phone Number", text: $text)
                    .fontWeight(.heavy)
                    .textFieldStyle(.aisleTextField)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.aisleDemoBackground)
    }
}
