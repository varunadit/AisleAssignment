//
//  AisleAssignmentApp.swift
//  AisleAssignment
//
//  Created by Varun Adit on 11/5/24.
//

import SwiftUI
import AppFeature

@main
struct AisleAssignmentApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            AppView(store: appDelegate.store)
//            PhoneNumberInputView()
//            { completeNumber in
//                print("Phone number submitted: \(completeNumber)")
//            }
        }
    }
}
