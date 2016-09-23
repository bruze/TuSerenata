//
//  Serenata.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/23/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import Firebase

class Serenata: NSObject {
    enum EstadoSerenata: Int {
        case Creada = 0
        case Aprobada = 1
        case Finalizada = 2
    }
    
    let key: String!
    let usuario: Usuario?
    let grupo: Musico?
    let detalles: DicStrStr
    let ref: FIRDatabaseReference?
    var estado: EstadoSerenata!
    
    // Initialize from arbitrary data
    init(usuarioID: String, grupoID: String, completed: Bool, key: String = "") {
        self.key = key
        self.usuario = nil
        self.grupo = nil
        self.estado = .Creada
        self.ref = nil
        self.detalles = [:]
        super.init()

        gerente.obtenerUsuario(usuarioID, finalizar: { usuario in self.usuario = usuario })
        gerente.obtenerMusico(grupoID, finalizar: { musico in self.grupo = musico })
    }
    
    init(captura: FIRDataSnapshot) {
        key = captura.key
        usuario = nil
        grupo = nil
        self.estado = .Creada
        self.ref = captura.ref
        self.detalles = [:]
        super.init()

        gerente.obtenerUsuario((captura.value!["usuarioID"] as? String)!, finalizar: {usuario in self.usuario = usuario})
        gerente.obtenerMusico((captura.value!["grupoID"] as? String)!, finalizar: {musico in self.grupo = musico})
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "usuarioID": usuario!.key,
            "grupoID": grupo?.key,
            //"estado": estado.debugDescription
        ]
    }
}
