//
//  Usuario.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/19/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import FirebaseDatabase

struct Usuario {
    let key: String!
    let nombre: String!
    //let genero: String!
    //let ref: Firebase?
    //var completed: Bool!
    
    // Initialize from arbitrary data
    init(nombre: String, genero: String, completed: Bool, key: String = "") {
        self.key = key
        self.nombre = nombre
        //self.genero = genero
        //self.completed = completed
        //self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        nombre = snapshot.value!["nombre"] as! String
        //genero = snapshot.value!["genero"] as! String
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "nombre": nombre//,
            //"genero": genero,
            //"completed": completed
        ]
    }
}