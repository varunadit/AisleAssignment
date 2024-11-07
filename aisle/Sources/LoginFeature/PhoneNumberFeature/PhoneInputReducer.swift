//
//  PhoneInputReducer.swift
//  aisle
//
//  Created by Varun Adit on 11/6/24.
//

import ComposableArchitecture
import Foundation
import SharedModels
import APIClient

@Reducer
public struct PhoneInputReducer : Sendable{
    
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
        case successResponse
    }
    
    @Dependency(\.apiClient.postPhoneNumber) var phoneNumberAPI
        
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .successResponse:
                state.otpInput = OTPInputReducer.State(phoneNumber: state.phoneNumber, countryCode: state.countryCode)
                return .none
            case let .didTapContinue(phoneNumber):
                state.phoneNumber = phoneNumber
                return .run { [phoneNumber = state.phoneNumber, countryCode = state.countryCode] send in
                    do {
                        let response = try await phoneNumberAPI(PhoneNumber(phoneNumber: countryCode+phoneNumber))
                        switch response {
                        case let .success(response):
                            if response.status == true {
                                await send(.successResponse)
                            }
                            break
                        case let .failure(error):
                            print(error)
                            break
                        }
                    } catch {
                        print(error)
                    }
                }
            case let .otpInput(presentationAction):
                switch presentationAction {
                case .dismiss:
                    return .none
                case let .presented(presentedAction):
                    switch presentedAction {
                    case .didTapResend:
                        return .send(.didTapContinue(state.phoneNumber))
                    case .didTapEditPhoneNumber:
                        state.otpInput = nil
                        return .none
                    default:
                        return .none
                    }
                }
            }
        }
        .ifLet(\.$otpInput, action: \.otpInput) {
            OTPInputReducer()
        }
    }
}
