//
//  RegistrationView.swift
//  shopCart
//
//  Created by Rajeev Choudhary on 12/03/25.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var emailText: String = ""
    @State private var passwordText: String = ""
    @State private var confirmPasswordText: String = ""
    @State private var isValidEmail = true
    @State private var isValidPassword = true
    @State private var isConfirmPasswordValid = true
    
//    @State private var showSheet = false
    
    var canProceed: Bool { //for hiding button without inputs
        Validator.validateEmail(emailText) &&
        Validator.validatePassword(passwordText) &&
        validateConfirm(confirmPasswordText)
    }
    
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        NavigationStack {
            ZStack{
                if viewModel.isLoading {
                    ProgressView()
                }
                VStack {
                    Text("Create an Account")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.darkgray)
                        .padding(.bottom)
                        .padding(.top, 68)
                    Text("Create an account, So you can shop online :) ")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.primaryGray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 120)
                    
                    EmailTextField(emailText: $emailText, isValidEmail: $isValidEmail)
                        .padding(.bottom, 5)
                    
                    PasswordTextField(passwordText: $passwordText, isValidPassword: $isValidPassword, validatePassword: Validator.validatePassword, errorText: "Your Password is not valid", placeholder: "Password")
                        .padding(.bottom, 5)
                    
                    PasswordTextField(passwordText: $confirmPasswordText, isValidPassword: $isConfirmPasswordValid, validatePassword: validateConfirm, errorText: "Your Password is not Matching", placeholder: "Confirm Password")
                        .padding(.bottom, 20)
                    
                    Text("Password should contain at least one uppercase letter, one lowercase letter, one digit \n and one special character")
                        .font(.system(size: 10, weight: .light))
                    
                    Button(action: {
                        Task{
                            try? await viewModel.createUser(email: emailText, password: passwordText)
                        }
                    }) {
                        Text("Sign Up")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .opacity(canProceed ? 1.0 : 0.5)
                    .disabled(!canProceed)
                    .padding(.top)
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Already have an account")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.darkgray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    
                    .padding()
                    
                    BottomView(googleAction: {}, appleAction: {}, facebookAction: {})
                    
                    Spacer()
                    
                }
                .opacity(viewModel.isLoading ? 0.5 : 1.0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [.gray, .white, .black]),
                                startPoint: .topTrailing,
                                endPoint: .bottomTrailing
                            )
                            .ignoresSafeArea()
                        )
        }
        .alert(viewModel.hasError ? "Error" : "Success", isPresented: $viewModel.showAlert) {
            if viewModel.hasError {
                Button("Try Again") {}
            } else {
                Button("OK") {
                    dismiss()
                }
            }
        } message: {
            Text(viewModel.alertMessage)
        }
//        .sheet(isPresented: $showSheet, content: LoginView())
    }
    
    func validateConfirm(_ password: String) -> Bool {
        passwordText == confirmPasswordText
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
