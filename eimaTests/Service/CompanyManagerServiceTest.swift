//
//  CompanyManagerServiceTest.swift
//  eimaTests
//
//  Created by Allan Gonzales on 2/1/24.
//

import Foundation

@testable import eima

class CompanyManagerServiceTest: CompanyService {
    
    func login(_ username: String, password: String) async -> Result<eima.Company, eima.NetworkError> {
        if username == "companya" && password == "123456" {
            return .success(Company(id: "A", name: "Company A", userName: "companya", password: "123456"))
        } else {
            return .failure(NetworkError(description: "You have entered wrong email/password, please try again"))
        }
    }
    
    
}
