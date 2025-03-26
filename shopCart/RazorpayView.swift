//
//  RazorpayPaymentCompletionProtocol.swift
//  shopCart
//
//  Created by Rajeev Choudhary on 26/03/25.
//

import SwiftUI
import Razorpay

class ViewController: UIViewController, RazorpayPaymentCompletionProtocol {

// typealias Razorpay = RazorpayCheckout

    var razorpay: RazorpayCheckout!
    override func viewDidLoad() {
        super.viewDidLoad()
        razorpay = RazorpayCheckout.initWithKey(razorpayTestKey, andDelegate: self)
    }
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
            self.showPaymentForm()
    }
}
