//
//  PhoneNumberResponse.swift
//  aisle
//
//  Created by Varun Adit on 11/7/24.
//

public struct PhoneNumberResponse: Codable, Equatable, Sendable {
    public let status: Bool
    
    public init(status: Bool) {
        self.status = status
    }
}
