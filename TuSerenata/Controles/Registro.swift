//
//  Registro.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/26/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
import FirebaseAuth
class Registro: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var clave: UITextField!
    @IBAction func irAtras(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
    }
    
    func intenteRegistro() {
        FIRAuth.auth()?.createUser(withEmail: email.text!, password: clave.text!, completion: { (usuario, error) in
            if error != nil {
                print(error!)
            }
            if usuario != nil {
                let nuevoUsuario = Usuario.init(nombre: "", ciudad: "", sexo: "", completed: true, key: usuario!.uid)
                let nuevoUsuarioReferencia = gerente.users.child(usuario!.uid)
                nuevoUsuarioReferencia.setValue(nuevoUsuario.toAnyObject())
                //usuario!.displayName =
                //print(usuario)
            }
            self.dismiss(animated: true, completion: { 
                
            })
        })
    }
}
