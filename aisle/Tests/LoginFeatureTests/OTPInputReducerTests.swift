//
//  OTPInputReducerTests.swift
//  aisle
//
//  Created by Varun Adit on 11/7/24.
//

import XCTest
import ComposableArchitecture
@testable import LoginFeature  

final class OTPInputReducerTests: XCTestCase {
    
    @MainActor
    func testOTPFlow_TimerStartTickStop() async {
        let clock = TestClock()
        
        let store = TestStore(
            initialState: OTPInputReducer.State(
                phoneNumber: "1234567890",
                countryCode: "+91",
                timer: 3
            )
        ) {
            OTPInputReducer()
        } withDependencies: {
            $0.continuousClock = clock
        }
        
        await store.send(.startTimer)
        
        await clock.advance(by: .seconds(1))
        await store.receive(.timerTicked) { state in
            state.timer = 2
        }
        
        await clock.advance(by: .seconds(1))
        await store.receive(.timerTicked) { state in
            state.timer = 1
        }
        
        await clock.advance(by: .seconds(1))
        await store.receive(.timerTicked) { state in
            state.timer = 0
        }
        
        await store.receive(.enableResend) { state in
            state.timerOn = false
        }
        
    }
    
    @MainActor
    func testOTPFlow_ResendAction() async {
        let clock = TestClock()
        
        let store = TestStore(
            initialState: OTPInputReducer.State(
                phoneNumber: "1234567890",
                countryCode: "+91",
                timer: 3
            )
        ) {
            OTPInputReducer()
        } withDependencies: {
            $0.continuousClock = clock
        }
        store.exhaustivity = .off
        
        await store.send(.didTapResend)
        await store.receive(.startTimer) { state in
            state.timer = 3
            state.timerOn = true
        }
    }
    
    @MainActor
        func testOTPFlow_EditPhoneNumber() async {
            let clock = TestClock()
            
            let store = TestStore(
                initialState: OTPInputReducer.State(
                    phoneNumber: "1234567890",
                    countryCode: "+91"
                )
            ) {
                OTPInputReducer()
            } withDependencies: {
                $0.continuousClock = clock
            }
            store.exhaustivity = .off
            
            await store.send(.didTapEditPhoneNumber)
        }
        
        @MainActor
        func testOTPFlow_ContinueWithOTP() async {
            let clock = TestClock()
            
            let store = TestStore(
                initialState: OTPInputReducer.State(
                    phoneNumber: "1234567890",
                    countryCode: "+91"
                )
            ) {
                OTPInputReducer()
            } withDependencies: {
                $0.continuousClock = clock
            }
            store.exhaustivity = .off
            
            await store.send(.didTapContinue(otp: "1234"))
        }
}
