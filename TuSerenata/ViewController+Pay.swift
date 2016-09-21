//
//  ViewController+Pay.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/21/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

extension ViewController: PayPalPaymentDelegate {
    internal var paypalConfig: PayPalConfiguration {
        get {
            return getProperty("paypalConfig", initial: PayPalConfiguration.init())
        }
        set {
            setValue(newValue, forProperty: "paypalConfig")
        }
    }
    internal func configPayPal() {
        paypalConfig = PayPalConfiguration.init()
        
        // See PayPalConfiguration.h for details and default values.
        // Should you wish to change any of the values, you can do so here.
        // For example, if you wish to accept PayPal but not payment card payments, then add:
        //_payPalConfiguration.acceptCreditCards = NO;
        
        // Or if you wish to have the user choose a Shipping Address from those already
        // associated with the user's PayPal account, then add:
        paypalConfig.payPalShippingAddressOption = .PayPal
    }
    func payPalPaymentDidCancel(paymentViewController: PayPalPaymentViewController) {
        
    }
    func payPalPaymentViewController(paymentViewController: PayPalPaymentViewController, didCompletePayment completedPayment: PayPalPayment) {
        
    }
}
