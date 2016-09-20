//
//  Gerente.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/19/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//
import FirebaseDatabase

class Gerente: NSObject {
    var usuario: Usuario? = nil
    static let unistancia = Gerente.init()
    func obtenerUsuario(uid: String, finalizar: (Usuario?) -> ()) {
        let users: FIRDatabaseReference = FirebaseRef.child("users")
        users.observeSingleEventOfType(.Value, withBlock: { (captura) in
            if captura.hasChild(uid) {
                finalizar(Usuario(snapshot: captura.childSnapshotForPath(uid)))
            }
        })
    }
}