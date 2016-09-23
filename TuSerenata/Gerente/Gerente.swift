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
    let users: FIRDatabaseReference = FirebaseRef.child("users")
    //var mensajes: [JLMessage]? = nil

    override init() {
        users.keepSynced(true)
        super.init()
    }
    
    static let unistancia = Gerente.init()
    func obtenerUsuario(uid: String, finalizar: (Usuario?) -> ()) {
        /*users.observeEventType(.Value, andPreviousSiblingKeyWithBlock: { (captura, llave) in
            if captura.hasChild(uid) {
                finalizar(Usuario(snapshot: captura.childSnapshotForPath(uid)))
            }
            }) { (error) in
                
        }*/
        users.observeEventType(.Value, withBlock: { (captura) in
            if captura.hasChild(uid) {
                let capturaUsuario = captura.childSnapshotForPath(uid)
                /*capturaUsuario.ref.observeEventType(.Value, withBlock: { (capturaU) in
                    print(capturaU)
                })*/
                if capturaUsuario.hasChild("musico") {
                    if (capturaUsuario.childSnapshotForPath("musico").value! as? Int)! == 0 {
                        finalizar(Usuario(snapshot: capturaUsuario))
                    } else {
                        if capturaUsuario.hasChild("genero") {
                            finalizar(Musico(captura: capturaUsuario))
                        } else {
                            return // esperar otro update del server
                        }
                    }
                } else {
                    return // esperar otro update del server
                }
            }
        })
    }
    func obtenerMusico(uid: String, finalizar: (Musico?) -> ()) {
        //let users: FIRDatabaseReference = FirebaseRef.child("users")
        users.observeSingleEventOfType(.Value, withBlock: { (captura) in
            if captura.hasChild(uid) {
                let capturaMusico = captura.childSnapshotForPath(uid)
                if (capturaMusico.childSnapshotForPath("musico").value! as? Int)! == 1 {
                    finalizar(Musico(captura: capturaMusico))
                } else {
                    print("El id buscado no corresponde a un grupo")
                }
            }
        })
    }
    func filtrarMusicos() {
        /*let query = users.observeSingleEventOfType(.Value) { (captura) in
            
        }
        print(query)*/
    }
    /*func obtenerMensajes(idUsuario: String) -> JLMessage? {
        let usuario = obtenerUsuario(idUsuario) { (usuario) in
            self.mensajes = 
        }
    }*/
}