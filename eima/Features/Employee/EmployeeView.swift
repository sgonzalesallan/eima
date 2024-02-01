//
//  EmployeeView.swift
//  eima
//
//  Created by Allan Gonzales on 2/1/24.
//


import SwiftUI

struct EmployeeView: View {
    
    @EnvironmentObject var coordinator: Coordinator<MapRouter>
    @StateObject var viewModel: EmployeeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if viewModel.pageType == .edit || viewModel.pageType == .add  {
                getEditView()
            } else if viewModel.pageType == .view {
                getDetailView()
            } else {
                EmptyView()
            }
        }.navigationTitle(viewModel.pageType.title)
    }
    
    @ViewBuilder func getDetailView() -> some View {
        VStack(alignment: .leading) {
            Text("Name")
                .font(.system(size: 16, weight: .bold, design: .default))
            Text(viewModel.employee?.name ?? "")
                .font(.system(size: 24, weight: .regular, design: .default))
            Divider()
            Text("Last Name")
                .font(.system(size: 16, weight: .bold, design: .default))
            Text(viewModel.employee?.lastName ?? "")
                .font(.system(size: 24, weight: .regular, design: .default))
            Divider()
            Text("Status")
                .font(.system(size: 16, weight: .bold, design: .default))
            Text(viewModel.employee?.status.title ?? "")
                .font(.system(size: 24, weight: .regular, design: .default))
            
            Button(
                action: {
                    self.viewModel.pageType = .edit
                }, label: {
                    Text("Edit")
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
            ).padding(.top, 20)
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    @ViewBuilder func getEditView() -> some View {
        VStack(alignment: .leading) {
            TextField("Name",
                      text: $viewModel.employeeName )
                .autocapitalization(.none)
                .disableAutocorrection(false)
                .padding(.top, 20)
            Divider()
            TextField("Last Name",
                      text: $viewModel.employeeLastName )
                .autocapitalization(.none)
                .disableAutocorrection(false)
                .padding(.top, 20)
            Divider()
            if viewModel.pageType == .edit {
                Toggle("Active Employment", isOn: $viewModel.isActive)
                Divider()
                Button(
                    action: {
                        Task {
                            await self.viewModel.updateEmployee()
                            self.viewModel.pageType = .view
                        }
                    }, label: {
                        Text("Update")
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                    
                ).padding(.top, 20)
                    .opacity(viewModel.employeeName.isEmpty || viewModel.employeeLastName.isEmpty ? 0.5 : 1.0)
                    .disabled(viewModel.employeeName.isEmpty || viewModel.employeeLastName.isEmpty)
                Button(
                    action: {
                        self.viewModel.pageType = .view
                    }, label: {
                        Text("Cancel")
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .foregroundColor(Color.black)
                        .cornerRadius(10)
                    }
                ).padding(.top, 20)
            } else {
                Button(
                    action: {
                        Task {
                            await self.viewModel.saveEmployee()
                            coordinator.pop()
                        }
                    }, label: {
                        Text("Save")
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                )
                .padding(.top, 20)
                .opacity(viewModel.employeeName.isEmpty || viewModel.employeeLastName.isEmpty ? 0.5 : 1.0)
                .disabled(viewModel.employeeName.isEmpty || viewModel.employeeLastName.isEmpty)
            }
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
}

