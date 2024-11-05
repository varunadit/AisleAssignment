//
//  AppDelegateReducer.swift
//  aisle
//
//  Created by Varun Adit on 11/5/24.
//

import Foundation
import ComposableArchitecture

public struct AppDelegateReducer: Reducer{
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action {
        case didFinishLaunching
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didFinishLaunching:
                return .none
            }
        }
    }
}
