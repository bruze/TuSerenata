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
        openPayment()
        
        //openChat()
    }
}

