//
//  AppDelegate.swift
//  aisle
//
//  Created by Varun Adit on 11/5/24.
//

import SwiftUI
import ComposableArchitecture

public final class AppDelegate: NSObject, UIApplicationDelegate {
    public let store = Store(
        initialState: AppReducer.State()
    ) {
        AppReducer()
    }
    
    // MARK: Application Did Finish Launching
    public func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        self.store.send(.appDelegate(.didFinishLaunching))
        return true
    }
}
