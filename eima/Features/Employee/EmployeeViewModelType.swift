//
//  EmployeeViewModelType.swift
//  eima
//
//  Created by Allan Gonzales on 2/1/24.
//

import Foundation

enum EmployeeViewModelType {
    case add, edit, view
    
    var title: String {
        switch self {
            case .add: return "Add Employee"
            case .edit: return "Edit Employee Detail"
            case .view: return "Employee Detail"
        }
    }
}
