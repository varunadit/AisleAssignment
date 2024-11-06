//
//  ContentView.swift
//  AisleAssignment
//
//  Created by Varun Adit on 11/5/24.
//

import SwiftUI
import AisleUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}


/// A view that displays a phone number input form with country code and number field
struct PhoneNumberInputView: View {
    @State private var phoneNumber: String = ""
    @State private var countryCode: String = "+91"
    var onContinue: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {

            titleSection
                .padding(.top, 36)
            
            HStack(spacing: 8) {
                countryCodeField
                    .frame(maxWidth: 80)
                phoneNumberField
                    .frame(maxWidth: 165)
            }
            
            Button {
                onContinue(countryCode + phoneNumber)
            } label: {
                Text("Continue")
                    .fontWeight(.bold)
            }
            .buttonStyle(.aislePrimary)
            .disabled(phoneNumber.isEmpty)
            
            Spacer()
        }
        .dynamicTypeSize(.xLarge)
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Get OTP")
                .font(.subheadline)
            
            Text("Enter Your\nPhone Number")
                .font(.title)
                .fontWeight(.heavy)
        }
        .foregroundStyle(.black)

    }
    
    private var countryCodeField: some View {
        Text(countryCode)
            .fontWeight(.black)
            .modifier(RoundedBorder())
    }
    
    private var phoneNumberField: some View {
        TextField("", text: $phoneNumber)
            .fontWeight(.black)
            .modifier(RoundedBorder())
            .keyboardType(.numberPad)
    }
}

/// A custom view modifier for styling phone input fields
struct RoundedBorder: ViewModifier {
    var width: CGFloat?
    
    func body(content: Content) -> some View {
        content
            .padding()
            .overlay (
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(red: 196/255, green: 196/255, blue: 196/255), lineWidth: 2)
            )
    }
}

/// A preview provider for the phone number input view
struct PhoneNumberInputView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberInputView { completeNumber in
            print("Phone number submitted: \(completeNumber)")
        }
    }
}

// MARK: - Input Validation

extension PhoneNumberInputView {
    /// Validates the phone number format
    private func isValidPhoneNumber(_ number: String) -> Bool {
        // Add your validation logic here
        return number.count == 10 && number.allSatisfy { $0.isNumber }
    }
}

// MARK: - String Extensions

extension String {
    /// Formats the phone number as it's being typed
    func formatPhoneNumber() -> String {
        // Add your phone number formatting logic here
        return self
    }
}
