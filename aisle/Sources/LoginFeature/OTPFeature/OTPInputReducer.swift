//
//  OTPInputReducer.swift
//  aisle
//
//  Created by Varun Adit on 11/7/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
public struct OTPInputReducer: Sendable {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public var otp: String = ""
        public var phoneNumber: String
        public var countryCode: String
        public var timerOn: Bool = true
        public var timer: Int
        public var timerDuration: Int
        public init(phoneNumber: String, countryCode: String, timer: Int = 60) {  // Public initializer
            self.phoneNumber = phoneNumber
            self.countryCode = countryCode
            self.timer = timer
            self.timerDuration = timer
        }
    }
    
    public enum Action: Equatable {  // Public action enum
        case didTapContinue(otp: String)
        case didTapEditPhoneNumber
        case didTapResend
        case startTimer
        case timerTicked
        case enableResend
    }
    
    private enum CancelID {
        case timer
    }
    
    @Dependency(\.continuousClock) var clock
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .didTapContinue(otp):
                return .none
            case .didTapEditPhoneNumber:
                return .none
            case .startTimer:
                state.timer = state.timerDuration
                let _ = withAnimation(.default) {
                    state.timerOn = true
                }
                return .run { send in
                    while true {
                        try await clock.sleep(for: .seconds(1))
                        await send(.timerTicked)
                    }
                }
                .cancellable(id: CancelID.timer)
            case .timerTicked:
                state.timer -= 1
                if state.timer == 0 {
                    return .send(.enableResend)
                }
                return .none
            case .enableResend:
                let _ = withAnimation(.default) {
                    state.timerOn = false
                }
                return .cancel(id: CancelID.timer)
            case .didTapResend:
                return .send(.startTimer)
            }
            
        }
    }
}
