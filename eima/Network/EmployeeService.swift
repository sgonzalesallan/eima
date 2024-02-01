//
//  EmployeeService.swift
//  eima
//
//  Created by Allan Gonzales on 2/1/24.
//

import Foundation

protocol EmployeeService {
    
    func getEmployeeList(_ companyId: String) async -> [Employee]
    func saveEmployee(_ companyId: String, employee: Employee) async
    func updateEmployee(_ companyId: String, employee: Employee) async
}

class EmployeeManagerService: EmployeeService {
    
    func getPathFor(companyId: String) -> String {
        return FileManagerHelper.shared.getJsonDataPath(fileName: "\(companyId).json")
    }
    
    func getEmployeeList(_ companyId: String) async -> [Employee] {
        do {
            let result = try await FileManagerHelper.shared.load([Employee].self, from: getPathFor(companyId: companyId))
            return result
        } catch {
            return []
        }
    }
    
    func saveEmployee(_ companyId: String, employee: Employee) async {
        var result = await getEmployeeList(companyId)
        do {
            result.append(employee)
            try await FileManagerHelper.shared.save(result, to: getPathFor(companyId: companyId))
        } catch {
            print("Error in saving...")
        }
    }
    
    func updateEmployee(_ companyId: String, employee: Employee) async {
        var result = await getEmployeeList(companyId)
        do {
            result = result.filter { $0.id != employee.id }
            result.append(employee)
            try await FileManagerHelper.shared.save(result, to: getPathFor(companyId: companyId))
        } catch {
            print("Error in saving...")
        }
    }
}
