//
//  HomeReducer.swift
//  aisle
//
//  Created by Varun Adit on 11/7/24.
//

import ComposableArchitecture
import SharedModels
import APIClient

@Reducer
public struct HomeReducer: Sendable {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public var isLoading = true
        public var profileList: ProfileListResponse?
        public init(profileList: ProfileListResponse? = nil) {
            self.profileList = profileList
        }
    }
    
    public enum Action: Equatable {
        case fetch
        case fetched(ProfileListResponse)
    }
    
    @Dependency(\.apiClient.getProfileList) var getProfileList
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetch:
                state.isLoading = true
                return .run { send in
                    do {
                        let response = try await getProfileList()
                        switch response {
                        case .success(let profileList):
                            await send(.fetched(profileList))
                        case .failure:
                            break
                        }
                    } catch {
                        print(error)
                    }
                }
            case let .fetched(profileList):
                state.isLoading = false
                state.profileList = profileList
                return .none
            }
            
        }
    }
}
