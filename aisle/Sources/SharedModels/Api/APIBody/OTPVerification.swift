//
//  OTPVerification.swift
//  aisle
//
//  Created by Varun Adit on 11/5/24.
//

public struct OTPVerification: Codable, Equatable, Sendable {
    let phoneNumber: String
    let otp: String
    
    public enum CodingKeys: String, CodingKey {
        case phoneNumber = "number"
        case otp
    }
    
    public init(phoneNumber: String, otp: String) {
        self.phoneNumber = phoneNumber
        self.otp = otp
    }
}
