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
    let grupos: FIRDatabaseReference = FirebaseRef.child("grupos")
    var musicosFiltrados: [Musico] = []
    //var mensajes: [JLMessage]? = nil

    override init() {
        users.keepSynced(true)
        grupos.keepSynced(true)
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
                        if capturaUsuario.hasChild("ciudad") {
                            finalizar(Usuario(snapshot: capturaUsuario))
                        }
                    } else {
                        if capturaUsuario.hasChild("genero") && capturaUsuario.hasChild("ciudad") {
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
        users.observeEventType(.Value, withBlock: { (captura) in
            if captura.hasChild(uid) {
                let capturaMusico = captura.childSnapshotForPath(uid)
                if capturaMusico.hasChild("musico") {
                    if (capturaMusico.childSnapshotForPath("musico").value! as? Int)! == 1 {
                        if capturaMusico.hasChild("genero") && capturaMusico.hasChild("ciudad") {
                            finalizar(Musico(captura: capturaMusico))
                        } else {
                            return // esperar actualización del servidor
                        }
                    } else {
                        print("El id buscado no corresponde a un grupo")
                    }
                }
            }
        })
    }
    func filtrarGrupos(condiciones: [ChequeoGrupo]) -> [Musico] {
        var gruposDeInteres: [Musico] = []
        for grupo in musicosFiltrados {
            var cumple = true
            for condicion in condiciones {
                if !condicion(grupo) {
                    cumple = false
                    break;
                }
            }
            if cumple {
                gruposDeInteres.append(grupo)
            }
        }
        return gruposDeInteres
    }
    func filtrarMusicos(notificar: BloqueVoid) /*-> [Musico]*/ {
        musicosFiltrados.removeAll()
        grupos.observeEventType(.ChildAdded, withBlock: { (captura) in
            for child in captura.children {
                self.obtenerMusico(child.key!!, finalizar: { musico in
                    if !self.musicosFiltrados.contains(musico!) {
                        self.musicosFiltrados.append(musico!)
                    }
                    if UInt(self.musicosFiltrados.count) == captura.childrenCount {
                        notificar()
                    }
                })
            }
        })
    }
}