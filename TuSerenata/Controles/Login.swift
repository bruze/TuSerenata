//
//  Login.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/16/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
import DualSlideMenu
import FirebaseAuth

class Login: UIViewController {
    internal func intenteLogueo() {
        FIRAuth.auth()?.signInWithEmail("dos@dos.com", password: "123456", completion: { (user, error) in
            if let loggedUser = user {
                let users = FirebaseRef.child("users")
                users.observeEventType(.Value, withBlock: { (captura) in
                    if captura.hasChild(loggedUser.uid) {
                        Gerente.unistancia.obtenerUsuario(loggedUser.uid, finalizar: { (usuario) in
                            Gerente.unistancia.usuario = usuario
                            appDelegate.mostrarPantallaAterrizaje()
                        })
                    } else {
                        // Los datos de usuario deberían encontrarse
                        // ya que se ingresan al hacer el flujo de registro
                        print("NO SE ENCONTRARON DATOS DEL USUARIO")
                    }
                })
            } else {
                // El usuario no se encontró
                print("NO SE ENCONTRO EL USUARIO EN EL SERVIDOR")
            }
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // 1
        /*FirebaseRef.observeAuthEventWithBlock { (authData) -> Void in
            // 2
            if authData != nil {
                // 3
                let storyboard = appDelegate.storyboard!
                let leftView = storyboard.instantiateViewControllerWithIdentifier("Menu")
                 let mainView = storyboard.instantiateInitialViewController()
                 
                 let slide = DualSlideMenuViewController(mainViewController: mainView!, leftMenuViewController: leftView)
                appDelegate.window?.rootViewController = slide
            }
        }*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
