//
//  TabReducer.swift
//  aisle
//
//  Created by Varun Adit on 11/7/24.
//
import ComposableArchitecture
import SharedModels


@Reducer
public struct TabReducer {
    
    public init() {}
    
    // MARK: State
    @ObservableState
    public struct State: Equatable, Hashable {
        public var selectedTab: TabModel = .notes
        
        public init(selectedTab: TabModel = .notes) {
            self.selectedTab = selectedTab
        }
    }
    
    // MARK: Action
    public enum Action: Equatable {
        
        case didSelectTab(TabModel)
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case didSelectTab(TabModel)
        }
    }
    
    // MARK: Reducer
    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case let .didSelectTab(tab):
                state.selectedTab = tab
                return .send(.delegate(.didSelectTab(tab)))
            case .delegate:
                return .none
            }
        }
    }
}
