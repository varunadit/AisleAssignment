//
//  ServerRoute.swift
//  aisle
//
//  Created by Varun Adit on 11/5/24.
//

import Foundation
import CasePaths
import SharedModels

public enum ServerRoute: Equatable {
    case api(API)
    case authenticate(Authenticate)
    
    public struct API: Equatable {
        public let authToken: String
        public let route: Route
        
        public init(authToken: String, route: Route) {
            self.authToken = authToken
            self.route = route
        }
        
        public enum Route: Equatable, Sendable {
            case profileList
        }
    }
    
    public struct Authenticate: Equatable {
        public let route: Route
        
        public init(route: Route) {
            self.route = route
        }
        
        public enum Route: Equatable, Sendable {
            case requestOTP(phoneNumber: PhoneNumber)
            case verifyOTP(OTPVerification)
        }
    }
}
