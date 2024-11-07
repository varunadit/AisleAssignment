//
//  OTPInputReducer.swift
//  aisle
//
//  Created by Varun Adit on 11/7/24.
//

import ComposableArchitecture
import SwiftUI
import APIClient
import SharedModels
import Foundation
import HomeFeature
import TabFeature

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
        @Presents public var root: RootReducer.State?
        
        public init(
            phoneNumber: String,
            countryCode: String, timer: Int = 60,
            root: RootReducer.State? = nil
        ) {  // Public initializer
            self.phoneNumber = phoneNumber
            self.countryCode = countryCode
            self.timer = timer
            self.timerDuration = timer
            self.root = root
        }
    }
    
    
    public enum Action: Equatable {  // Public action enum
        case didTapContinue(otp: String)
        case didTapEditPhoneNumber
        case didTapResend
        case startTimer
        case timerTicked
        case enableResend
        case loginSuccess
        case root(PresentationAction<RootReducer.Action>)
    }
    
    private enum CancelID {
        case timer
    }
    
    @Dependency(\.continuousClock) var clock
    @Dependency(\.apiClient.postOTP) var postOTP
    
    public var body: some ReducerOf<Self> {
        
        Reduce { state, action in
            switch action {
            case let .didTapContinue(otp):
                state.timer = Int.random(in: 59...60)
                return .run { [phoneNumber = state.phoneNumber, countryCode = state.countryCode] send in
                    let response = try await postOTP(OTPVerification(phoneNumber: countryCode+phoneNumber, otp: otp))
                    switch response {
                    case let .success(otpResponse):
                        await send(.loginSuccess)
                        break
                    case let .failure(error):
                        print(error)
                        break
                    }
                }
                //                return .none
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
            case .loginSuccess:
                state.root = RootReducer.State()
                return .none
            case .root(_):
                return .none
            }
            
        }
        .ifLet(\.$root, action: \.root) {
            RootReducer()
        }
    }
}
