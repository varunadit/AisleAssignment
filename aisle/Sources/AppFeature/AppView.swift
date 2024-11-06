//
//  AppView.swift
//  aisle
//
//  Created by Varun Adit on 11/5/24.
//

import SwiftUI
import LoginFeature
import ComposableArchitecture

public struct AppView: View {
    let store: StoreOf<AppReducer>
    public init(store: StoreOf<AppReducer>) {
        self.store = store
    }
    
    public var body: some View {
        PhoneNumberInputView(store: store.scope(state:\.phoneNumberInput, action: \.phoneNumberInput))
    }
}
