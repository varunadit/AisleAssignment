//
//  AppReducer.swift
//  aisle
//
//  Created by Varun Adit on 11/5/24.
//

import ComposableArchitecture

@Reducer
public struct AppReducer {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public var appDelegate: AppDelegateReducer.State
        
        public init(
            appDelegate: AppDelegateReducer.State = AppDelegateReducer.State()
        ) {
            self.appDelegate = appDelegate
        }
    }
    
    @CasePathable
    @dynamicMemberLookup
    public enum Action: Equatable {
        case appDelegate(AppDelegateReducer.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.appDelegate, action: \.appDelegate) {
            AppDelegateReducer()
        }
        Reduce { state, action in
            switch action {
            case .appDelegate(.didFinishLaunching):
                return .none
            case .appDelegate:
                return .none
            }
        }
    }
    
}
