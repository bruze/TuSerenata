//
//  UIViewController+Pay.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/26/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import AssociatedValues

extension UIViewController: PayPalPaymentDelegate {
    //MARK:PAYMENT
    func openPayment() {
        let payment = PayPalPayment.init()
        
        // Amount, currency, and description
        payment.amount = 19.95
        payment.currencyCode = "USD";
        payment.shortDescription = "Awesome saws";
        
        // Use the intent property to indicate that this is a "sale" payment,
        // meaning combined Authorization + Capture.
        // To perform Authorization only, and defer Capture to your server,
        // use PayPalPaymentIntentAuthorize.
        // To place an Order, and defer both Authorization and Capture to
        // your server, use PayPalPaymentIntentOrder.
        // (PayPalPaymentIntentOrder is valid only for PayPal payments, not credit card payments.)
        payment.intent = .sale
        
        // If your app collects Shipping Address information from the customer,
        // or already stores that information on your server, you may provide it here.
        //payment.shippingAddress = address; // a previously-created PayPalShippingAddress object
        
        // Several other optional fields that you can set here are documented in PayPalPayment.h,
        // including paymentDetails, items, invoiceNumber, custom, softDescriptor, etc.
        
        // Check whether payment is processable.
        if (!payment.processable) {
            // If, for example, the amount was negative or the shortDescription was empty, then
            // this payment would not be processable. You would want to handle that here.
        }
        
        // Create a PayPalPaymentViewController.
        let paymentViewController = PayPalPaymentViewController.init(payment: payment, configuration: paypalConfig, delegate: self)
        
        // Present the PayPalPaymentViewController.
        present(paymentViewController!, animated: true, completion: nil)
    }
    internal var paypalConfig: PayPalConfiguration {
        get {
            return getAssociatedValue(key: "paypalConfig", object: self, initialValue: PayPalConfiguration.init())
        }
        set {
            set(associatedValue: newValue, key: "paypalConfig", object: self)
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
        paypalConfig.payPalShippingAddressOption = .payPal
    }
    public func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        
    }
    
    public func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        dismiss(animated: true, completion: {})
    }
}
