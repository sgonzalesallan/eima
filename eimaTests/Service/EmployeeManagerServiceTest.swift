//
//  EmployeeManagerServiceTest.swift
//  eimaTests
//
//  Created by Allan Gonzales on 2/1/24.
//

import Foundation

@testable import eima

class EmployeeManagerServiceTest: EmployeeService {
    
    private var emptyResult: Bool
    
    init(emptyResult: Bool) {
        self.emptyResult = emptyResult
    }
    
    func getEmployeeList(_ companyId: String) async -> [eima.Employee] {
        if let url = Bundle(for: EmployeeManagerServiceTest.self).url(forResource: "employeeList", withExtension: "json"), !emptyResult {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let model = try decoder.decode([Employee].self, from: data)
                return model
            } catch (let error) {
                let errorDesc = error.localizedDescription
                print("error: \(errorDesc)")
                return []
            }
        } else {
            return []
        }
    }
    
    func saveEmployee(_ companyId: String, employee: eima.Employee) async {
        
    }
    
    func updateEmployee(_ companyId: String, employee: eima.Employee) async {
        
    }
    
    
}
