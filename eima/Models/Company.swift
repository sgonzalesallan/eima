//
//  Company.swift
//  eima
//
//  Created by Allan Gonzales on 2/1/24.
//

import Foundation

struct Company: Codable {
    var id: String
    var name: String
    var userName: String
    var password: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case userName = "userName"
        case password = "password"
    }
}
