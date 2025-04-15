import UIKit
import SwiftUI
import Razorpay

struct PaymentGatewayHelper: UIViewControllerRepresentable {
    
    @EnvironmentObject var router: Router<ViewPath>
    
    func makeUIViewController(context: Context) -> CheckoutViewController {
        .init()
    }
    
    func updateUIViewController(_ uiViewController: CheckoutViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        
        var parent: PaymentGatewayHelper
        
        init(_ parent: PaymentGatewayHelper) {
            self.parent = parent
            
            super.init()
        }
    }
}