//
//  Musico.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/15/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import Foundation
import Firebase

class Musico: Usuario {
    
    //let key: String!
    var voz: String
    var genero: String
    var estrellas: Int
    
    //let ref: FIRDatabaseReference?
    //var completed: Bool!
    
    // Initialize from arbitrary data
    init(nombre: String, genero: String, ciudad: String, voz: String, completed: Bool, key: String = "") {
        self.genero = genero
        self.voz = voz
        self.estrellas = 0
        super.init(nombre: nombre, ciudad: ciudad, sexo: "NINGUNO", completed: completed, key: key)
        //self.completed = completed
        //self.ref = nil
    }
    
    init(captura: FIRDataSnapshot) {
        
        let dict = anytool.dicstrany(any: captura.value!)
        //nombre = (dict["nombre"] as? String)!
        genero = (dict["genero"] as? String)!
        //ciudad = (dict["ciudad"] as? String)!
        voz = (dict["voces"] as? String)!
        estrellas = (dict["estrellas"] as? Int)!
        super.init(snapshot: captura)
       /* key = snapshot.key
        genero = snapshot.value["genero"] as! String
        nombre = snapshot.value["nombre"] as! String
        completed = snapshot.value["completed"] as! Bool
        ref = snapshot.ref*/
    }
    
    override func toAnyObject() -> AnyObject {
        return ([
            "nombre": nombre,
            "genero": genero,
            "ciudad": ciudad,
            "musico": 1,
            "voces": voz,
            "estrellas": estrellas
        ] as? AnyObject)!
    }
    
    deinit {
        
    }
}
