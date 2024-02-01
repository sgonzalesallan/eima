//
//  MapRouter.swift
//  eima
//
//  Created by Allan Gonzales on 2/1/24.
//

import SwiftUI

enum MapRouter: NavigationRouter {
    
    case loginView
    case dashboardView(companyId: String)
    
    case employeeView(companyId: String, employee: Employee?, pageType: EmployeeViewModelType)

    var transition: NavigationTransitionStyle {
        switch self {
        case .loginView, .dashboardView:
            return .change
        case .employeeView:
            return .push
        }
    }
    
    @ViewBuilder
    public func view() -> some View {
        switch self {
        case .loginView:
            LoginView(viewModel: LoginViewModel(service: CompanyManagerService()))
        case .dashboardView(let companyId):
            DashboardView(viewModel: DashboardViewModel(companyId: companyId, service: EmployeeManagerService()))
        case .employeeView(let companyId, let employee, let pageType):
            EmployeeView(viewModel: EmployeeViewModel(companyId: companyId, employee: employee, service: EmployeeManagerService(), pageType: pageType))
        }
    }
}
