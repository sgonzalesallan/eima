//
//  dashboardTests.swift
//  eimaTests
//
//  Created by Allan Gonzales on 2/1/24.
//

import XCTest

@testable import eima

final class dashboardTests: XCTestCase {

    func testGetEmployeeList() async throws {
        
        let model = DashboardViewModel(companyId: "A", service: EmployeeManagerServiceTest(emptyResult: false))
                
        await model.getEmployeeList()
        
        XCTAssertTrue(!model.employeeList.isEmpty, "Employee list should not be empty")
        XCTAssertEqual(model.companyId, "A", "Company id should not empty")
        
        XCTAssertTrue(model.employeeList.count == 2, "Employee list count should be equal to 2")
        
        if let first = model.employeeList.first {
            XCTAssertEqual(first.name, "Allan", "First employee name should be the same from the source")
            XCTAssertEqual(first.lastName, "Gonzales", "First employee last name should be the same from the source")
            XCTAssertEqual(first.id, "158E4487-9DFB-4EBB-BEAD-7C8888201DF8", "First employee id name should be the same from the source")
            XCTAssertEqual(first.status, .active, "First employee status should be the same from the source")

        }
        
        if let last = model.employeeList.last {
            XCTAssertEqual(last.name, "Joyce", "Last employee name should be the same from the source")
            XCTAssertEqual(last.lastName, "Mendoza", "Last employee last name should be the same from the source")
            XCTAssertEqual(last.id, "45F63AFC-087D-4881-B367-A6B8F5AEB277", "Last employee id name should be the same from the source")
            XCTAssertEqual(last.status, .resign, "Last employee status should be the same from the source")
        }
        
    }
    
    func testGetEmployeeListEmpty() async throws {
        let model = DashboardViewModel(companyId: "A", service: EmployeeManagerServiceTest(emptyResult: true))
                
        await model.getEmployeeList()
        
        XCTAssertTrue(model.employeeList.isEmpty, "Employee list should be empty")
    }

}
