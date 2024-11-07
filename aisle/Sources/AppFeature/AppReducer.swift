//
//  AppReducer.swift
//  aisle
//
//  Created by Varun Adit on 11/5/24.
//

import ComposableArchitecture
import LoginFeature
@Reducer
public struct AppReducer {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public var appDelegate: AppDelegateReducer.State
        public var phoneNumberInput: PhoneInputReducer.State
        
        public init(
            appDelegate: AppDelegateReducer.State = AppDelegateReducer.State(),
            phoneNumberInput: PhoneInputReducer.State = PhoneInputReducer.State()
        ) {
            self.appDelegate = appDelegate
            self.phoneNumberInput = phoneNumberInput
        }
    }
    
    @CasePathable
    @dynamicMemberLookup
    public enum Action: Equatable {
        case appDelegate(AppDelegateReducer.Action)
        case phoneNumberInput(PhoneInputReducer.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.appDelegate, action: \.appDelegate) {
            AppDelegateReducer()
        }
        Scope(state: \.phoneNumberInput, action: \.phoneNumberInput) {
            PhoneInputReducer()
        }
        Reduce { state, action in
            switch action {
            case .appDelegate(.didFinishLaunching):
                return .none
            case .appDelegate:
                return .none
            case .phoneNumberInput:
                return .none
            }
        }
    }
    
}
