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
    var nombre: String
    var ciudad: String
    var sexo: String
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
        nombre  = anytool.dicstrany(any: snapshot.value!)["nombre"] as! String
        ciudad  = anytool.dicstrany(any: snapshot.value!)["ciudad"] as! String
        sexo = ""
        if snapshot.hasChild("sexo") {
            sexo   = anytool.dicstrany(any: snapshot.value!)["sexo"] as! String
        }
         //sexo   = anytool.dicstrany(any: snapshot.value!)["sexo"] as! String
         ref = snapshot.ref
        if snapshot.hasChild("mensajes") {
            let mensajes = snapshot.childSnapshot(forPath: "mensajes")
            self.refMensajes = mensajes.ref
            self.refMensajes?.keepSynced(true)
            if mensajes.hasChild("nuevos") {
                let mensajesNuevos = mensajes.childSnapshot(forPath: "nuevos")
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
        return ([
            "nombre": nombre,
            "ciudad": ciudad,
            "sexo": sexo,
            "musico": 0
            //"genero": genero,
            //"completed": completed
        ] as? AnyObject)!
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
        ref!.observe(.value, andPreviousSiblingKeyWith: { (captura, llave) in
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
        return self.isKind(of: Musico.self)
    }
}
