//
//  LoginViewModel.swift
//  eima
//
//  Created by Allan Gonzales on 2/1/24.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    var companyId: String
    
    private let service: CompanyService
    
    init(service: CompanyService, companyId: String = "") {
        self.service = service
        self.companyId = companyId
    }
    
    func login() async {
        let result = await service.login(username, password: password)
        switch result {
            case .success(let company):
                await setErrorMessage(message: "")
                companyId = company.id
            case .failure(let error):
                await setErrorMessage(message: error.description)
                companyId = ""
        }
    }
    
    @MainActor private func setErrorMessage(message: String) {
        errorMessage = message
    }
    
}
