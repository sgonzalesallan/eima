//
//  DashboardView.swift
//  eima
//
//  Created by Allan Gonzales on 2/1/24.
//

import SwiftUI

struct DashboardView: View {

    @EnvironmentObject var coordinator: Coordinator<MapRouter>
    @StateObject var viewModel: DashboardViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.employeeList, id: \.self) { employee in
                HStack {
                    Text(employee.fullName())
                    Spacer()
                    Text(employee.status.title)
                        .foregroundColor(Color.white)
                        .background(employee.status.color)
                        .cornerRadius(5)
                        .padding(5)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    coordinator.show(.employeeView(companyId: viewModel.companyId!, employee: employee, pageType: .view))
                }
            }.refreshable {
                Task {
                    await viewModel.getEmployeeList()
                }
            }
            .overlay(Group {
                if viewModel.employeeList.isEmpty {
                    Text("No Employee found")
                }
            })
            .navigationTitle("Employee")
            .toolbar {
                Button {
                    coordinator.show(.employeeView(companyId: viewModel.companyId!, employee: nil, pageType: .add))
                } label: {
                    Image(systemName: "plus")
                }
            }.onAppear {
                Task {
                    await viewModel.getEmployeeList()
                }
            }
        }
    }
    
}
