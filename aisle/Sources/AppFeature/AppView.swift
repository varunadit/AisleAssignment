//
//  AppView.swift
//  aisle
//
//  Created by Varun Adit on 11/5/24.
//

import SwiftUI
import LoginFeature
import ComposableArchitecture
import TabFeature
import HomeFeature
import SharedModels

public struct AppView: View {
    @Bindable var store: StoreOf<AppReducer>
    public init(store: StoreOf<AppReducer>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack {
            Group {
                    PhoneNumberInputView(store: store.scope(state:\.phoneNumberInput, action: \.phoneNumberInput))
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar(.hidden, for: .navigationBar)
            }
        }
    }
}
