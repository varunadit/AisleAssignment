//
//  OTPInputView.swift
//  aisle
//
//  Created by Varun Adit on 11/7/24.
//

import SwiftUI
import ComposableArchitecture
import AisleUI

public struct OTPInputView: View {
    
    @State var otp: String = ""
    @Bindable var store: StoreOf<OTPInputReducer>
    
    public init(store: StoreOf<OTPInputReducer>) {
        self.store = store
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            titleSection
                .padding(.top, 36)
            
            otpField
                .frame(maxWidth: 50)
                .modifier(RoundedBorder())
            
            HStack(spacing: 12){
                Button {
                    store.send(.didTapContinue(otp: otp))
                } label: {
                    Text("Continue")
                        .fontWeight(.bold)
                }
                .buttonStyle(.aislePrimary)
                .disabled(!isValidOTP(otp))
                
                if store.timerOn {
                    Text("00:\(store.timer)")
                        .fontWeight(.bold)
                } else {
                    Button("Resend OTP") {
                        store.send(.didTapResend)
                    }
                    .buttonStyle(.aislePrimary)
                    .fontWeight(.bold)
                }
                
            }
            
            Spacer()
        }
        .dynamicTypeSize(...(.xLarge))
        .foregroundStyle(.black)
        .onAppear(perform: {
            store.send(.startTimer)
        })
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.aisleDemoBackground)
        .navigationDestination(item: $store.scope(state: \.root, action: \.root)) { store in
            RootView(store: store)
                .toolbar(.hidden, for: .navigationBar)
        }
        
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Text(store.countryCode + " " + store.phoneNumber)
                Button {
                    store.send(.didTapEditPhoneNumber)
                } label: {
                    Image(systemName: "pencil")
                        .resizable()
                        .scaledToFit()
                        .fontWeight(.black)
                }
                .buttonStyle(.plain)
                .frame(width: 14, height: 14)
            }
            .font(.body)
            .fontWeight(.medium)
            
            Text("Enter The\nOTP")
                .font(.title)
                .fontWeight(.heavy)
        }
        .foregroundStyle(.black)
    }
    
    private var otpField: some View {
        TextField("", text: $otp.limit(to: 4))
            .fontWeight(.black)
            .font(.body)
            .keyboardType(.numberPad)
            .textContentType(.telephoneNumber)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Input Validation

extension OTPInputView {
    /// Validates the phone number format
    private func isValidOTP(_ otp: String) -> Bool {
        return otp.count == 4 && otp.allSatisfy { $0.isNumber }
    }
}

#Preview {
    OTPInputView(
        store: Store(
            initialState: OTPInputReducer.State(phoneNumber: "9876543212", countryCode: "+91", timer: 1),
            reducer: {
                OTPInputReducer()
            }
        )
    )
}
