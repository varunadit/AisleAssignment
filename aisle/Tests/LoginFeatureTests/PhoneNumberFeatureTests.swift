//
//  PhoneNumberFeatureTests.swift
//  aisle
//
//  Created by Varun Adit on 11/7/24.
//

import XCTest
import ComposableArchitecture
@testable import LoginFeature

@MainActor
final class PhoneNumberFeatureTests: XCTestCase {
    
    func testInitialState() async {
        let store = TestStore(initialState: PhoneInputReducer.State()) {
            PhoneInputReducer()
        }
        
        XCTAssertEqual(store.state.phoneNumber, "")
        XCTAssertEqual(store.state.countryCode, "+91")
        XCTAssertNil(store.state.otpInput)
    }
    
    func testCustomInitialState() async {
        let store = TestStore(
            initialState: PhoneInputReducer.State(
                phoneNumber: "1234567890",
                countryCode: "+1"
            )
        ) {
            PhoneInputReducer()
        }
        
        XCTAssertEqual(store.state.phoneNumber, "1234567890")
        XCTAssertEqual(store.state.countryCode, "+1")
    }

    func testDidTapContinue() async {
        let store = TestStore(initialState: PhoneInputReducer.State()) {
            PhoneInputReducer()
        }
        
        await store.send(.didTapContinue("1234567890")) { state in
            state.phoneNumber = "1234567890"
            state.otpInput = OTPInputReducer.State(
                phoneNumber: "1234567890",
                countryCode: "+91"
            )
        }
    }
    
    func testOTPScreen_EditPhoneNumber() async {
        let store = TestStore(
            initialState: PhoneInputReducer.State()
        ) {
            PhoneInputReducer()
        }
        
        await store.send(.didTapContinue("1234567890")) { state in
            state.phoneNumber = "1234567890"
            state.otpInput = OTPInputReducer.State(
                phoneNumber: "1234567890",
                countryCode: "+91"
            )
        }
        
        await store.send(.otpInput(.presented(.didTapEditPhoneNumber))) { state in
            state.otpInput = nil
        }
    }
    
    func testOTPScreen_Dismiss() async {
        let store = TestStore(
            initialState: PhoneInputReducer.State(
                phoneNumber: "1234567890",
                countryCode: "+91",
                otpInput: OTPInputReducer.State(
                    phoneNumber: "1234567890",
                    countryCode: "+91"
                )
            )
        ) {
            PhoneInputReducer()
        }
        
        await store.send(.otpInput(.dismiss)) {
            $0.otpInput = nil
        }
    }
 
    func testFullFlow_PhoneToOTPAndBack() async {
        let store = TestStore(initialState: PhoneInputReducer.State()) {
            PhoneInputReducer()
        }
        
        await store.send(.didTapContinue("1234567890")) { state in
            state.phoneNumber = "1234567890"
            state.otpInput = OTPInputReducer.State(
                phoneNumber: "1234567890",
                countryCode: "+91"
            )
        }
        
        await store.send(.otpInput(.presented(.didTapEditPhoneNumber))) { state in
            state.otpInput = nil
        }
        
        await store.send(.didTapContinue("9876543210")) { state in
            state.phoneNumber = "9876543210"
            state.otpInput = OTPInputReducer.State(
                phoneNumber: "9876543210",
                countryCode: "+91"
            )
        }
    }
    
}

