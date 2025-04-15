//
//  PaymentGatewayHelper.swift
//  shopCart
//
//  Created by Rajeev Choudhary on 01/04/25.
//

//import UIKit
//import SwiftUI
//import Razorpay
//
//struct PaymentGatewayHelper: UIViewControllerRepresentable {
//    
//    @EnvironmentObject var router: Router<ViewPath>
//    
//    func makeUIViewController(context: Context) -> CheckoutViewController {
//        .init()
//    }
//    
//    func updateUIViewController(_ uiViewController: CheckoutViewController, context: Context) {}
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    class Coordinator: NSObject {
//        
//        var parent: PaymentGatewayHelper
//        
//        init(_ parent: PaymentGatewayHelper) {
//            self.parent = parent
//            
//            super.init()
//        }
//    }
//}
//
//class CheckoutViewController: UIViewController, RazorpayPaymentCompletionProtocolWithData {
//        
//    static var razorpayTestKey = "rzp_test_" //Put your Razorpay API Key.
//
//    var razorpay: RazorpayCheckout!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        razorpay = RazorpayCheckout.initWithKey(razorpay_test_key, andDelegateWithData: self)
//        
//        let walletView = WalletScreen {
//            self.showPaymentForm()
//        }
//
//        let vc = UIHostingController(rootView: walletView)
//        let swiftUIView = vc.view!
//        view.addSubview(swiftUIView)
//        swiftUIView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            swiftUIView.topAnchor.constraint(equalTo: view.topAnchor),
//            swiftUIView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            swiftUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            swiftUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//        
//        addChild(vc)
//        vc.didMove(toParent: self)
//    }
