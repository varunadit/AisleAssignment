//
//  PhoneInputReducer.swift
//  aisle
//
//  Created by Varun Adit on 11/6/24.
//

import ComposableArchitecture
import Foundation

@Reducer
public struct PhoneInputReducer {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        
        public init(phoneNumber: String = "", countryCode: String = "+91", otpInput: OTPInputReducer.State? = nil) {
            self.phoneNumber = phoneNumber
            self.countryCode = countryCode
            self.otpInput = otpInput
        }
        public var phoneNumber: String
        public var countryCode: String
        @Presents public var otpInput: OTPInputReducer.State?

    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case didTapContinue(String)
        case otpInput(PresentationAction<OTPInputReducer.Action>)
    }
        
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case let .didTapContinue(phoneNumber):
                state.phoneNumber = phoneNumber
                state.otpInput = OTPInputReducer.State(phoneNumber: phoneNumber, countryCode: state.countryCode)
                return .none
            case let .otpInput(presentationAction):
                switch presentationAction {
                case .dismiss:
                    return .none
                case let .presented(presentedAction):
                    switch presentedAction {
                    case .didTapResend:
                        return .none
                    case .didTapEditPhoneNumber:
                        state.otpInput = nil
                        return .none
                    default:
                        return .none
                    }
                }
                return .none
            }
        }
        .ifLet(\.$otpInput, action: \.otpInput) {
            OTPInputReducer()
        }
    }
}
