//
//  String+Binding.swift
//  aisle
//
//  Created by Varun Adit on 11/7/24.
//

import SwiftUI

public extension Binding where Value == String {
    func limit(to length: Int) -> Self {
        if self.wrappedValue.count > length {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(length))
            }
        }
        return self
    }
}
