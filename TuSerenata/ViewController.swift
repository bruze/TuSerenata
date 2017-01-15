//
//  ViewController.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/15/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
import DualSlideMenu

import AssociatedValues

class ViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        PayPalMobile.preconnect(withEnvironment: PayPalEnvironmentNoNetwork)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configPayPal()
        localizador.delegate = self
        localizador.startUpdatingLocation()
        setInitialRecognizeButtonHeight()
        setupTable()
        //mostrarCarga()
        //gerente.filtrarMusicos({ self.notificarActualizarFiltrados() }, condiciones: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }

    func notificarActualizarFiltrados() {
        //print(gerente.filtrarGrupos([{(musico: Musico) in musico.nombre.contains("land")}]))
        ocultarCarga()
        print("se actualizaron los filtrados")
    }
    
    func seleccioneTipoReserva() {
        ventanaEmergente(["acc1": "Reserva Inmediata", "acc2": "Reserva Fecha"], acciones: [{ print("Aun no creada esta vista") }, { self.performSegue(withIdentifier: "crearSerenata", sender: nil) }])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func itemMenuTap(_ sender: UIBarButtonItem) {
        //print(Gerente.unistancia.usuario?.toAnyObject())
        guard gerente.usuario != nil else {
            appDelegate.logout()
            return
        }
        (appDelegate.slide!.leftMenu as? MenuVC)!.nombre.text = gerente.usuario!.nombre
        appDelegate.slide!.toggle("right")
    }

    @IBAction func rightItemTap(_ sender: UIBarButtonItem) {
        //openPayment()
        
        openChat()
    }
}

