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
    //Registro Usuario
    @IBOutlet weak var genero: UITextField!
    @IBOutlet weak var ciudad: UITextField!
    @IBOutlet weak var apellido: UITextField!
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var clave: UITextField!
    @IBOutlet weak var confirma: UITextField!
    //Registro Grupo
    @IBOutlet weak var nombreGrupo: UITextField!
    @IBOutlet weak var generoGrupo: UITextField!
    @IBOutlet weak var ciudadGrupo: UITextField!
    @IBOutlet weak var emailGrupo: UITextField!
    @IBOutlet weak var claveGrupo: UITextField!
    @IBOutlet weak var confirmaGrupo: UITextField!
    
    @IBAction func irAtras(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    var registrandoGrupo: Bool {
        get {
            return !camposGrupo.isHidden
        }
    }
    var botonF: AMKButton {
        get {
            return (view.viewWithTag(4)! as? AMKButton)!
        }
    }
    var botonM: AMKButton {
        get {
            return (view.viewWithTag(5)! as? AMKButton)!
        }
    }
    var vocesGrupo: String {
        get {
            var resultado = "NINGUNO"
            if botonF.selected {
                if botonM.selected {
                    resultado = "AMBOS"
                    //return "AMBOS"
                } else {
                    resultado = "F"
                    //return "F"
                }
            } else if botonM.selected {
                resultado = "M"
                //return "M"
            }
            //var array: [ChequeoGrupo] = []
            //print(gerente.musicosPor(&array, musicos: gerente.musicosFiltrados))
            return resultado
            //return "NINGUNO"
        }
    }
    override func viewDidLoad() {
    }
    func seleccionGenero(_ boton: AnyObject) {
        if (boton as? AMKButton)!.selected {
            (boton as? AMKButton)!.labelFontColor = UIColor.white
        } else {
            (boton as? AMKButton)!.labelFontColor = UIColor.black
        }
    }
    func ocultarBotonesHabilitar() {
        botonHabilitarGrupo.isHidden = true
        botonHabilitarUsuario.isHidden = true
    }
    func habilitarRegistroUsuario() {
        ocultarBotonesHabilitar()
        botonRegistro.isHidden = false
        camposUsuario.isHidden = false
    }
    func habilitarRegistroGrupo() {
        ocultarBotonesHabilitar()
        botonRegistro.isHidden = false
        camposGrupo.isHidden = false
    }
    func intenteRegistro() {
        if registrandoGrupo {
            FIRAuth.auth()?.createUser(withEmail: emailGrupo.text!, password: claveGrupo.text!, completion: { (usuario, error) in
                if error != nil {
                    print(error!)
                }
                if usuario != nil {
                    /*let nuevoUsuario = Usuario.init(nombre: self.nombre.text!+" "+self.apellido.text!, ciudad: self.ciudad.text!, sexo: self.genero.text!, completed: true, key: usuario!.uid)*/
                    let nuevoGrupo = Musico.init(nombre: self.nombreGrupo.text!, genero: self.generoGrupo.text!, ciudad: self.ciudadGrupo.text!, voz: self.vocesGrupo, completed: true, key: usuario!.uid)
                    //let nuevoUsuarioReferencia = gerente.users.child(usuario!.uid)
                    //nuevoUsuarioReferencia.setValue(nuevoUsuario.toAnyObject())
                    let nuevoGrupoReferencia = gerente.users.child(usuario!.uid)
                    nuevoGrupoReferencia.setValue(nuevoGrupo.toAnyObject())
                    let nuevoMusicoReferencia = gerente.grupos.child("musicos").child(usuario!.uid)
                    nuevoMusicoReferencia.setValue(1)
                    //usuario!.displayName =
                    //print(usuario)
                }
                self.dismiss(animated: true, completion: {
                    
                })
            })
        } else {
            FIRAuth.auth()?.createUser(withEmail: email.text!, password: clave.text!, completion: { (usuario, error) in
                if error != nil {
                    print(error!)
                }
                if usuario != nil {
                    let nuevoUsuario = Usuario.init(nombre: self.nombre.text!+" "+self.apellido.text!, ciudad: self.ciudad.text!, sexo: self.genero.text!, completed: true, key: usuario!.uid)
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
}
