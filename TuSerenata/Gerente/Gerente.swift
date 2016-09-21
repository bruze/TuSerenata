//
//  Gerente.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/19/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//
import FirebaseDatabase
import JLChatViewController

class Gerente: NSObject {
    var usuario: Usuario? = nil
    //var mensajes: [JLMessage]? = nil

    static let unistancia = Gerente.init()
    func obtenerUsuario(uid: String, finalizar: (Usuario?) -> ()) {
        let users: FIRDatabaseReference = FirebaseRef.child("users")
        /*users.observeEventType(.Value, andPreviousSiblingKeyWithBlock: { (captura, llave) in
            if captura.hasChild(uid) {
                finalizar(Usuario(snapshot: captura.childSnapshotForPath(uid)))
            }
            }) { (error) in
                
        }*/
        users.observeSingleEventOfType(.Value, withBlock: { (captura) in
            if captura.hasChild(uid) {
                finalizar(Usuario(snapshot: captura.childSnapshotForPath(uid)))
            }
        })
    }
    /*func obtenerMensajes(idUsuario: String) -> JLMessage? {
        let usuario = obtenerUsuario(idUsuario) { (usuario) in
            self.mensajes = 
        }
    }*/
}