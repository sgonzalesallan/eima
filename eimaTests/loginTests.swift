//
//  loginTests.swift
//  eimaTests
//
//  Created by Allan Gonzales on 2/1/24.
//

import XCTest

@testable import eima

final class loginTests: XCTestCase {

    func testLoginSuccess() async throws {
        
        let model = LoginViewModel(service: CompanyManagerServiceTest())
        model.username = "companya"
        model.password = "123456"
        
        await model.login()
        
        XCTAssertTrue(model.errorMessage.isEmpty, "Successful login should have no error message")
        XCTAssertEqual(model.companyId, "A", "Successful login should have right company id")
    }
    
    func testLoginError() async throws {
        let model = LoginViewModel(service: CompanyManagerServiceTest())
        model.username = "companya"
        model.password = "12345"
        
        await model.login()
        XCTAssertEqual(model.errorMessage, "You have entered wrong email/password, please try again", "Unsuccessful login should have right error message")
        
        XCTAssertEqual(model.companyId, "", "Unsuccessful login should have no company id")
    }

}
