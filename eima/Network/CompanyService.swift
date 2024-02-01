//
//  CompanyService.swift
//  eima
//
//  Created by Allan Gonzales on 2/1/24.
//

import Foundation

protocol CompanyService {
    func login(_ username: String, password: String) async -> Result<Company, NetworkError>
}

class CompanyManagerService: CompanyService {
    private var companyList: [Company] = [
        Company(id: "A", name: "Company A", userName: "companya", password: "123456"),
        Company(id: "B", name: "Company B", userName: "companyb", password: "123456"),
        Company(id: "C", name: "Company C", userName: "companyc", password: "123456"),
        Company(id: "D", name: "Company D", userName: "companyd", password: "123456")
    ]
    
    func login(_ username: String, password: String) async -> Result<Company, NetworkError> {
        let result = companyList.filter { $0.userName == username && password == $0.password }
        if let first = result.first {
            return (.success(first))
        } else {
            return (.failure(NetworkError(description: "You have entered wrong email/password, please try again")))
        }
    }
}
