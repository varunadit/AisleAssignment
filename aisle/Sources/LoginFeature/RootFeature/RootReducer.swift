//
//  RootReducer.swift
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
public struct RootReducer: Sendable {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
       
        public var home: HomeReducer.State
        public var tabBar: TabReducer.State
        
        public init(
            home: HomeReducer.State = HomeReducer.State(),
            tabBar: TabReducer.State = TabReducer.State()
        ) {
            self.home = home
            self.tabBar = tabBar
        }
    }
    
    public enum Action: Equatable {  
        case home(HomeReducer.Action)
        case tabBar(TabReducer.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.home, action: \.home) {
            HomeReducer()
        }
        Scope(state: \.tabBar, action: \.tabBar) {
            TabReducer()
        }
        Reduce { state, action in
            switch action {
            case .home(_):
                return .none
            case .tabBar(_):
                return .none
            }
            
        }
    }
}
