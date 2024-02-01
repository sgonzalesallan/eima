//
//  DashboardViewModel.swift
//  eima
//
//  Created by Allan Gonzales on 2/1/24.
//

import SwiftUI

class DashboardViewModel: ObservableObject {
    
    @Published var employeeList: [Employee]
    @Published var companyId: String?
    
    private let service: EmployeeService
    
    init(companyId: String, service: EmployeeService, employeeList: [Employee] = []) {
        self.service = service
        self.companyId = companyId
        self.employeeList = employeeList
    }
    
    func getEmployeeList() async {
        guard let id = self.companyId else { return }
        let result = await self.service.getEmployeeList(id)
        await setEmployeeList(employeeList: result)
    }
    
    @MainActor private func setEmployeeList(employeeList: [Employee]) {
        self.employeeList = employeeList.sorted { $0.lastName < $1.lastName }
    }
    
}

