//
//  MenuVC.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/16/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import DualSlideMenu

@IBDesignable class MenuVC: UIViewController, DualSlideMenuViewControllerDelegate {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var nombre: UILabel!
    var crearSerenata: AMKButton? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        if let boton = view.viewWithTag(1) as? AMKButton {
            crearSerenata = boton
            crearSerenata?.addBlock({ self.irACrearSerenata() }, ForAction: 0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func logout() {
        try! Auth.auth().signOut()
        appDelegate.authorize()
    }
    func irACrearSerenata() {
        appDelegate.slide!.toggle("right")
        let navegador = ((ez.topMostVC! as? DualSlideMenuViewController)!.mainView as? UINavigationController)!
        navegador.childViewControllers[0].performSegue(withIdentifier: "crearSerenata", sender: nil)
    }
    
    func onSwipe() {
        nombre.text = gerente.usuario!.nombre
    }
    
    func didChangeView() {
        
    }
}
