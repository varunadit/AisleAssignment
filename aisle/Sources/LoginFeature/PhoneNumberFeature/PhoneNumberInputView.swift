//
//  PhoneNumberInputView.swift
//  aisle
//
//  Created by Varun Adit on 11/6/24.
//

import SwiftUI
import AisleUI
import ComposableArchitecture
/// A view that displays a phone number input form with country code and number field
public struct PhoneNumberInputView: View {
    @State private var phoneNumber: String = ""
    @Bindable var store: StoreOf<PhoneInputReducer>
    public init(store: StoreOf<PhoneInputReducer>) {
        self.store = store
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 24) {

            titleSection
                .padding(.top, 36)
            
            HStack(spacing: 8) {
                countryCodeField
                    .frame(maxWidth: 40, alignment: .center)
                    .modifier(RoundedBorder())

                phoneNumberField
                    .frame(maxWidth: 130)
                    .modifier(RoundedBorder())
            }
            
            Button {
                store.send(.didTapContinue(phoneNumber))
            } label: {
                Text("Continue")
                    .fontWeight(.bold)
            }
            .buttonStyle(.aislePrimary)
            .disabled(!isValidPhoneNumber(phoneNumber))
            
            Spacer()
        }
        .navigationDestination(item: $store.scope(state: \.otpInput, action: \.otpInput)) { store in
            OTPInputView(store: store)
                .toolbar(.hidden, for: .navigationBar)
        }
        .dynamicTypeSize(...(.xLarge))
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.aisleDemoBackground)
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
        Text(store.countryCode)
            .padding(1)
            .font(.body)
            .fontWeight(.black)
            .disabled(true)
    }
    
    private var phoneNumberField: some View {
        TextField("", text: $phoneNumber.limit(to: 10))
            .fontWeight(.black)
            .font(.body)
            .keyboardType(.numberPad)
            .textContentType(.telephoneNumber)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Input Validation

extension PhoneNumberInputView {
    /// Validates the phone number format
    private func isValidPhoneNumber(_ number: String) -> Bool {
        return number.count == 10 && number.allSatisfy { $0.isNumber }
    }
}

// MARK: - Preview
/// A preview provider for the phone number input view
struct PhoneNumberInputView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberInputView(
            store:
                Store(initialState: PhoneInputReducer.State(), reducer: {
                    PhoneInputReducer()
                        ._printChanges()
                })
        )
    }
}


