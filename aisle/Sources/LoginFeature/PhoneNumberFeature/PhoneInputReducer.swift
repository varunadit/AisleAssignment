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
        
        public init(phoneNumber: String = "", countryCode: String = "+91") {
            self.phoneNumber = phoneNumber
            self.countryCode = countryCode
        }
        var phoneNumber: String
        var countryCode: String
        var focusedField: Field?

        enum Field: String, Hashable {
          case phoneNumber
        }
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case didTapContinue(String)
    }
    
    @Dependency(\.mainQueue) var mainQueue
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case let .didTapContinue(phoneNumber):
                state.phoneNumber = phoneNumber
                return .none
            }
        }
    }
}
