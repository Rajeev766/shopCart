//
//  shopCartApp.swift
//  shopCart
//
//  Created by Rajeev Choudhary on 10/03/25.
//

import SwiftUI
import Firebase

@main
struct shopCartApp: App {
    @StateObject private var viewModel = ViewModel()
    @StateObject private var cartViewModel = CartViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                Onboard()
            }
            .environmentObject(viewModel)
            .environmentObject(cartViewModel)
        }
    }
}
