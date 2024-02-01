//
//  EmployeeStatus.swift
//  eima
//
//  Created by Allan Gonzales on 2/1/24.
//

import SwiftUI

extension Employee {
    
    enum Status: String, Codable {
        case active = "active"
        case resign = "resign"
        
        var title: String {
            return self.rawValue.uppercased()
        }
        
        var color: Color {
            switch self {
            case .active: return .green
            case.resign: return .red
            }
        }
        
        var isActive: Bool {
            switch self {
            case .active: return true
            case.resign: return false
            }
        }
        
    }
}
