//
//  EmployeeViewModel.swift
//  eima
//
//  Created by Allan Gonzales on 2/1/24.
//

import SwiftUI

class EmployeeViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var companyId: String?
    
    @Published var employeeName: String = ""
    @Published var employeeLastName: String = ""
    @Published var isActive: Bool = false
    
    @Published var pageType: EmployeeViewModelType
    @Published var employee: Employee?

    private let service: EmployeeService
    
    init(companyId: String, employee: Employee? = nil, service: EmployeeService, pageType: EmployeeViewModelType) {
        self.service = service
        self.companyId = companyId
        self.pageType = pageType
        self.employee = employee
        if self.employee != nil {
            employeeName = employee?.name ?? ""
            employeeLastName = employee?.lastName ?? ""
            isActive = employee?.status.isActive ?? false
        }
    }
    
    func saveEmployee() async {
        guard let id = self.companyId else { 
            return }
        let model = Employee(id: UUID().uuidString, 
                             name: employeeName,
                             lastName: employeeLastName,
                             status: .active)
        await self.service.saveEmployee(id, employee: model)
    }
    
    func updateEmployee() async {
        guard let id = self.companyId, let employeeId = self.employee?.id else {
            return }
        
        guard let _ = self.employee else { return }
        await changeDetail(name: employeeName, lastName: employeeLastName, isActive: isActive)
        await self.service.updateEmployee(id, employee: employee!)
    }

    @MainActor private func changeDetail(name: String, lastName: String, isActive: Bool) {
        employee?.status = isActive ? .active : .resign
        employee?.name = name
        employee?.lastName = lastName
    }

}

