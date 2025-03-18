//
//  LoginView.swift
//  shopCart
//
//  Created by Rajeev Choudhary on 12/03/25.
//

import SwiftUI

enum FocusedField {
    case email
    case password
}

struct LoginView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var emailText = ""
    @State private var passwordText = ""
    @State private var isValidEmail = true
    @State private var isValidPassword = true
    @FocusState private var focusedField: FocusedField?
    
    @State private var showSheet = false
    
    var canProceed: Bool {
        Validator.validateEmail(emailText) && Validator.validatePassword(passwordText)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                }
                VStack {
                    Text("Login Here")  //Title
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.darkgray)
                        .padding(.bottom)
                    Text("Welcome Back!\n Please login to continue :) ") //Description
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(.primaryGray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 80)
                    
                    EmailTextField(emailText: $emailText, isValidEmail: $isValidEmail)
                    
                        .padding(.bottom, 5)
                    
                    PasswordTextField(passwordText: $passwordText, isValidPassword: $isValidPassword, validatePassword: Validator.validatePassword, errorText: "Your Password is Invalid", placeholder: "Password")
                    
                    HStack{
                        Spacer()
                        Text("Forgot your Password?") //Password Forgot Button
                            .foregroundColor(.primaryGray)
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .padding(.trailing)
                    .padding(.vertical)
                    
                    Button{
                        Task {
                            try? await viewModel.login(email: emailText, password: passwordText)
                        }
                    } label: {
                        Text("Login")
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
                    
                    Button{
                        showSheet.toggle()
                    } label: {
                        Text("Create New Account")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.darkgray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .padding()
                    
                    BottomView(googleAction: {}, appleAction: {}, facebookAction: {})
                    
                }
            }
            .navigationDestination(isPresented: $viewModel.isLoggedIn) {
                Text("Logged In!")
            }
            .navigationBarBackButtonHidden(true)
            .opacity(viewModel.isLoading ? 0.5 : 1.0)
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
        .alert("Error", isPresented: $viewModel.showAlert) {
            Button("OK") {
                isValidEmail = false
                isValidPassword = false
                emailText = ""
                passwordText = ""
            }
        } message: {
            Text(viewModel.alertMessage)
        }
        .sheet(isPresented: $showSheet) {
            RegistrationView()
        }
    }
}

struct LoginView_Previews: PreviewProvider { //screen view
    static var previews: some View {
        LoginView()
    }
}

struct BottomView: View {
    var googleAction: () -> Void
    var appleAction: () -> Void
    var facebookAction: () -> Void
    
    var body: some View {
        VStack{
            Text("or Continue with Using")
                .foregroundStyle(.darkgray)
                .font(.system(size: 20, weight: .semibold))
            HStack{
                Button(action: {
                    googleAction()
                }) {
                    Image("google-logo")
                }
                .iconButtonStyle

                Button(action: {
                    appleAction()
                }) {
                    Image("apple-logo")
                }
                .iconButtonStyle
                
                Button(action: {
                    facebookAction()
                }) {
                    Image("facebook-logo")
                }
                .iconButtonStyle
            }
        }
    }
}

extension View {
    var iconButtonStyle: some View { //button style for similar buttons
        self.padding()
            .background(Color(.primaryGray))
            .cornerRadius(8)
    }
}

struct EmailTextField: View {
    @Binding var emailText: String
    @Binding var isValidEmail: Bool
    @FocusState var focusedField: FocusedField?

    var body: some View {
        VStack {
            TextField("Enter your email address", text: $emailText)
                .focused($focusedField, equals: .email)
                .padding()
                .background(.gray)
                .cornerRadius(12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(!isValidEmail ? .red: focusedField == .email ? Color(.blue): .gray, lineWidth: 3)
                )
                .padding(.horizontal)
                .onChange(of: emailText) { newValue in isValidEmail = Validator.validateEmail(newValue) }
        }
        if !isValidEmail {
            HStack{
                Text("Invalid Email")
                    .foregroundColor(.red)
                    .padding(.leading)
                Spacer()
            }
            .padding(.bottom, !isValidEmail ? 16 : 0)
        }
    }
}

struct PasswordTextField: View {
    @Binding var passwordText: String
    @Binding var isValidPassword: Bool
    @FocusState var focusedField: FocusedField?
    
    let validatePassword: (String) -> Bool
    let errorText: String
    let placeholder: String

    var body: some View {
        VStack {
            SecureField(placeholder, text: $passwordText)
                .focused($focusedField, equals: .password)
                .padding()
                .background(.gray)
                .cornerRadius(12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(!isValidPassword ? .red: focusedField == .password ? Color(.blue): .gray, lineWidth: 3)
                )
                .padding(.horizontal)
                .onChange(of: passwordText) { newValue in isValidPassword = Validator.validatePassword(newValue) }
        }
        if !isValidPassword {
            HStack{
                Text(errorText)
                    .foregroundColor(.red)
                    .padding(.leading)
                Spacer()
            }
            .padding(.bottom, isValidPassword ? 16 : 0)
        }
    }
}

struct LoggedView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                }
                VStack {
                    Text("You are logged in!")
                        .font(.system(size: 24, weight: .bold))
                        .padding(.vertical)
                    
                    Button {
                        Task {
                            try? await viewModel.logout()
                        }
                    } label: {
                        Text("Log out")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(Color("primarygray"))
                    .cornerRadius(12)
                    .padding()
                }
                }
            .opacity(viewModel.isLoading ? 0.5 : 1.0)
            .navigationBarBackButtonHidden(true)
            }
        }
    }
