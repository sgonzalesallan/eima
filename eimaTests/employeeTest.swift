//
//  employeeTest.swift
//  eimaTests
//
//  Created by Allan Gonzales on 2/1/24.
//

import XCTest

@testable import eima

final class employeeTest: XCTestCase {

    func testEmployeeDetailView() async throws {
        let dashboardModel = DashboardViewModel(companyId: "A", service: EmployeeManagerServiceTest(emptyResult: false))
        
        await dashboardModel.getEmployeeList()
        if let first = dashboardModel.employeeList.first {
            let model = EmployeeViewModel(companyId: "A", employee: first, service: EmployeeManagerServiceTest(emptyResult: false),  pageType: .view)
            XCTAssertEqual(model.employeeName, "Allan", "First employee name should be the same from the source")
            XCTAssertEqual(model.employeeLastName, "Gonzales", "First employee last name should be the same from the source")
            XCTAssertEqual(model.employee?.id, "158E4487-9DFB-4EBB-BEAD-7C8888201DF8", "First employee id name should be the same from the source")
            XCTAssertEqual(model.employee?.status, .active, "First employee status should be the same from the source")
        } else {
            XCTFail("Should have employee to view")
        }
    }
    
    func testEmployeeEdit() async throws {
        let dashboardModel = DashboardViewModel(companyId: "A", service: EmployeeManagerServiceTest(emptyResult: false))
        
        await dashboardModel.getEmployeeList()
        if let first = dashboardModel.employeeList.first {
            let model = EmployeeViewModel(companyId: "A", employee: first, service: EmployeeManagerServiceTest(emptyResult: false),  pageType: .view)
            
            model.employeeName = "New Allan"
            model.employeeLastName = "New Gonzales"
            
            await model.updateEmployee()
            
            XCTAssertEqual(model.employeeName, "New Allan", "First employee detail should be equal to edited name")
            XCTAssertEqual(model.employeeLastName, "New Gonzales", "First employee detail should be equal to edited last name")
            XCTAssertEqual(model.employee?.id, "158E4487-9DFB-4EBB-BEAD-7C8888201DF8", "First employee id name should be the same from the source")
        } else {
            XCTFail("Should have employee to view")
        }
    }
    
    func testEmployeeStatusUpdate() async throws {
        let dashboardModel = DashboardViewModel(companyId: "A", service: EmployeeManagerServiceTest(emptyResult: false))
        
        await dashboardModel.getEmployeeList()
        if let first = dashboardModel.employeeList.first {
            let model = EmployeeViewModel(companyId: "A", employee: first, service: EmployeeManagerServiceTest(emptyResult: false),  pageType: .view)
            
            model.isActive = false
            
            await model.updateEmployee()
            
            XCTAssertEqual(model.employee?.status, .resign, "First employee status should be resign")
        } else {
            XCTFail("Should have employee to view")
        }
    }
    
}
