//
//  onboard.swift
//  shopCart
//
//  Created by Rajeev Choudhary on 11/03/25.
//

import SwiftUI

enum ViewStack {
    case login
    case registration
}

struct Onboard: View {
    @State private var presentNextView = false
    @State private var nextView: ViewStack = .login
    
    var body: some View {
        NavigationStack {
            VStack{
                Image("cosmetic")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 450)
                    .padding(.top, 24)
                    .blendMode(.darken)
                    .blendMode(.multiply)
                
                Spacer()
                
                Text("Your Cosmetics Needs Are Here")
                    .font(.system(size: 34, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.black)
                    .padding(.bottom, 8)
                
                Text("Discover premium beauty and skincare products for your flawless glow.")
                    .font(.system(size: 16, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.primaryGray)
                    .padding(.bottom)
                    .padding(.bottom, 8)
                
                Spacer()
                
                HStack(spacing: 30){
                    Button{
                        nextView = .login
                        presentNextView.toggle()
                    } label: {
                        Text("Login")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color.gray)
                    }
                    .frame(width: 160, height: 60)
                    .background(Color.black)
                    .cornerRadius(12)

                    Button{
                        nextView = .registration
                        presentNextView.toggle()
                    } label: {
                        Text("Sign Up")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color.black)
                    }
                    .frame(width: 160, height: 60)
                    .background(Color.gray)
                    .cornerRadius(12)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [.primaryGray.opacity(0.8), .white, .black]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                            .ignoresSafeArea()
                        )
            .navigationDestination(isPresented: $presentNextView) {
                switch nextView {
                case .login:
                    LoginView()
                case .registration:
                    RegistrationView()
                }
            }
        }
    }
}

struct Onboard_Previews: PreviewProvider {
    static var previews: some View {
        Onboard()
    }
}
