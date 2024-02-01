//
//  ContentView.swift
//  eima
//
//  Created by Allan Gonzales on 2/1/24.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var coordinator: Coordinator<MapRouter>
    @StateObject var viewModel: LoginViewModel

    var body: some View {
        VStack {
            Image(systemName: "scribble.variable")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.blue)
                .frame(width: 100, height: 100)
            Spacer()
            Text(viewModel.errorMessage)
                .font(.system(size: 16, weight: .regular, design: .default))
                .frame(maxWidth: .infinity, maxHeight: 60)
                .foregroundColor(Color.red)
            VStack {
                TextField("Username",
                          text: $viewModel.username)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.top, 20)
                Divider()
                SecureField(
                    "Password",
                    text: $viewModel.password
                )
                .padding(.top, 20)
                Divider()
            }
            Spacer()
            Button(
                action: {
                    Task {
                        await self.viewModel.login()
                        if (viewModel.errorMessage.isEmpty) {
                            coordinator.show(.dashboardView(companyId: viewModel.companyId))
                        }
                    }
                }, label: {
                    Text("Login")
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
            )
            .opacity(viewModel.username.isEmpty || viewModel.password.isEmpty ? 0.5 : 1.0)
            .disabled(viewModel.username.isEmpty || viewModel.password.isEmpty)
        }
        .padding(30)
    }
}
