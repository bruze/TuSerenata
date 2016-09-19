//
//  Musico.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/15/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import Foundation
import Firebase

struct Musico {
    
    let key: String!
    let nombre: String!
    let genero: String!
    //let ref: Firebase?
    var completed: Bool!
    
    // Initialize from arbitrary data
    init(nombre: String, genero: String, completed: Bool, key: String = "") {
        self.key = key
        self.nombre = nombre
        self.genero = genero
        self.completed = completed
        //self.ref = nil
    }
    
    /*init(/*snapshot: FDataSnapshot*/) {
       /* key = snapshot.key
        genero = snapshot.value["genero"] as! String
        nombre = snapshot.value["nombre"] as! String
        completed = snapshot.value["completed"] as! Bool
        ref = snapshot.ref*/
    }*/
    
    func toAnyObject() -> AnyObject {
        return [
            "nombre": nombre,
            "genero": genero,
            "completed": completed
        ]
    }
    
}