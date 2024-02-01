//
//  Employee.swift
//  eima
//
//  Created by Allan Gonzales on 2/1/24.
//

import Foundation

struct Employee: Codable, Identifiable, Hashable {
    
    var id: String
    var name: String
    var lastName: String
    var status: Employee.Status
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case lastName = "lastName"
        case status = "status"
    }
    
    func fullName() -> String {
        return "\(lastName), \(name)"
    }

}
