//
//  PhoneNumberFeatureTests.swift
//  aisle
//
//  Created by Varun Adit on 11/7/24.
//

import XCTest
import ComposableArchitecture
@testable import LoginFeature

final class PhoneNumberFeatureTests: XCTestCase {
    
    @MainActor
    func testPhoneNumberReducer() async throws {
        let store = await TestStore(initialState: PhoneInputReducer.State()) {
            PhoneInputReducer()
        }
        
        await store.send(.didTapContinue("1234567890")) { state in
            state.phoneNumber = "1234567890"
        }
    }
    
}
