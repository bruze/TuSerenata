//
//  ViewController.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/15/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
import DualSlideMenu
import JLChatViewController
import PropertyExtensions

class ViewController: UIViewController {

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        PayPalMobile.preconnectWithEnvironment(PayPalEnvironmentNoNetwork)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configPayPal()
        localizador.delegate = self
        localizador.startUpdatingLocation()
        setInitialRecognizeButtonHeight()
        setupTable()
        gerente.filtrarMusicos({ self.notificarActualizarFiltrados() })
        // Do any additional setup after loading the view, typically from a nib.
    }

    func notificarActualizarFiltrados() {
        print("se actualizaron los filtrados")
    }
    
    func seleccioneTipoReserva() {
        ventanaEmergente(["acc1": "Reserva Inmediata", "acc2": "Reserva Fecha"], acciones: [{ print("Aun no creada esta vista") }, { self.performSegueWithIdentifier("crearSerenata", sender: nil) }])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func itemMenuTap(sender: UIBarButtonItem) {
        //print(Gerente.unistancia.usuario?.toAnyObject())
        (appDelegate.slide!.leftMenu as? MenuVC)!.nombre.text = gerente.usuario!.nombre
        appDelegate.slide!.toggle("right")
    }

    @IBAction func rightItemTap(sender: UIBarButtonItem) {
        /*let payment = PayPalPayment.init()
        
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
        payment.intent = .Sale
        
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
        presentViewController(paymentViewController!, animated: true, completion: nil)*/
        
        if let vc = JLBundleController.instantiateJLChatVC() as? ChatVC {
         
            vc.view.frame = self.view.frame
            
            let chatSegue = UIStoryboardSegue(identifier: "goChat", source: self, destination: vc, performHandler: { () -> Void in
                vc.contestatario = gerente.musicosFiltrados[0]
                self.navigationController?.pushViewController(vc, animated: true)
            })
            
            self.prepareForSegue(chatSegue, sender: nil)
            
            chatSegue.perform()
        }
    }
}

