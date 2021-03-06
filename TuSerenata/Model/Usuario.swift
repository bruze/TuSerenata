//
//  Usuario.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/19/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import FirebaseDatabase
import JLChatViewController

class Usuario: NSObject {
    let key: String!
    let nombre: String!
    let ciudad: String!
    private let sexo: String!
    let ref: FIRDatabaseReference?
    var refMensajes: FIRDatabaseReference?
    var mensajesNuevos: [JLMessage]?
    //var completed: Bool!
    
    // Initialize from arbitrary data
    init(nombre: String, ciudad: String, sexo: String, completed: Bool, key: String = "") {
        self.key = key
        self.nombre = nombre
        self.ciudad = ciudad
        self.sexo = sexo
        //self.completed = completed
        self.ref = nil
        super.init()
    }

    init(snapshot: FIRDataSnapshot) {
         key    = snapshot.key
        nombre  = snapshot.value!["nombre"] as! String
        ciudad  = snapshot.value!["ciudad"] as! String
         sexo   = snapshot.value!["sexo"] as! String
         ref = snapshot.ref
        if snapshot.hasChild("mensajes") {
            let mensajes = snapshot.childSnapshotForPath("mensajes")
            self.refMensajes = mensajes.ref
            self.refMensajes?.keepSynced(true)
            if mensajes.hasChild("nuevos") {
                let mensajesNuevos = mensajes.childSnapshotForPath("nuevos")
            }
            /*if mensajes.hasChild("viejos") {
                let mensajesViejos = mensajes.childSnapshotForPath("viejos")
                print(mensajesViejos)
            }*/
            //checkearNuevosMensajes()
        }
        super.init()
        cargarMensajes()
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "nombre": nombre,
            "ciudad": ciudad,
            "sexo": sexo
            //"genero": genero,
            //"completed": completed
        ]
    }
    
    func cargarMensajes() {
        /*ref!.observeSingleEventOfType(.Value, withBlock: { (captura) in
            if captura.hasChild("mensajes") {
                let mensajes = captura.childSnapshotForPath("mensajes")
                self.refMensajes = mensajes.ref
                let mensajesNuevos = mensajes.childSnapshotForPath("nuevos")
                self.checkearNuevosMensajes()
            }
        })*/
        ref!.observeEventType(.Value, andPreviousSiblingKeyWithBlock: { (captura, llave) in
            //print(llave)
            //print(captura)
            }) { (error) in
                
        }
    }
    
    func checkearNuevosMensajes() {
        guard refMensajes != nil else {
            return
        }
        //refMensajes.obs
    }
    
    func esMusico() -> Bool {
        return self.isKindOfClass(Musico)
    }
}