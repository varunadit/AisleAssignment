//
//  TabModel.swift
//  aisle
//
//  Created by Varun Adit on 11/7/24.
//


public enum TabModel: String, Equatable, CaseIterable, Identifiable {
    case discover = "Discover"
    case notes = "Notes"
    case matches = "Matches"
    case profile = "Profile"
    
    public var id: Int {
        switch self {
        case .discover: return 1
        case .notes: return 2
        case .matches: return 3
        case .profile: return 4

        }
    }
    
    public var selectedSystemImage: String {
        switch self {
        case .discover: return "square.grid.2x2.fill"
        case .notes: return "envelope.fill"
        case .matches: return "bubble.fill"
        case .profile: return "person.fill"
        }
    }
}
