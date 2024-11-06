//
//  PhoneNumber.swift
//  aisle
//
//  Created by Varun Adit on 11/5/24.
//

public struct PhoneNumber: Codable, Equatable, Sendable {
    public var phoneNumber: String
    
    public enum CodingKeys: String, CodingKey {
        case phoneNumber = "number"
    }
    
    public init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
}
