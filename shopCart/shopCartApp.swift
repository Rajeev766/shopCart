//
//  shopCartApp.swift
//  shopCart
//
//  Created by Rajeev Choudhary on 10/03/25.
//

import SwiftUI

@main
struct shopCartApp: App {
    @StateObject var viewModel = ViewModel(service: AppService())

    var body: some Scene {
        WindowGroup {
            Onboard()
                .environmentObject(viewModel)
        }
    }
}
