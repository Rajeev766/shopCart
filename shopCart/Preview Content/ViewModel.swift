//
//  ViewModel.swift
//  shopCart
//
//  Created by Rajeev Choudhary on 17/03/25.
//

import Foundation

@MainActor
class ViewModel: ObservableObject {
    private let service: AppService
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var hasError = false
    @Published var isLoading = false
    @Published var isLoggedIn = false
    
    
    init(service: AppService) {
        self.service = service
    }
    
    func createUser(email: String, password: String) async throws {
        isLoading = true
        let status = try await service.createUser(email: email, password: password)
        
        switch status {
        case .success:
            isLoading = false
            alertMessage = "Your account has been created successfully!"
            showAlert.toggle()
        case .error(let message):
            isLoading = false
            hasError = true
            alertMessage = message
            showAlert.toggle()
        }
    }

    func login(email: String, password: String) async throws {
        isLoading = true
        let status = try await service.login(email: email, password: password)
        
        switch status {
        case .success:
            isLoading = false
            isLoggedIn = true
        case .error(let message):
            isLoading = false
            hasError = true
            alertMessage = message
            showAlert.toggle()
        }
    }
    
    func logout() async throws {
        isLoading = true
        let status = try await service.logout()
        
        switch status {
        case .success:
            isLoading = false
            isLoggedIn = false
        case .error(let message):
            isLoading = false
            hasError = true
            alertMessage = message
            showAlert.toggle()
        }
    }
}

