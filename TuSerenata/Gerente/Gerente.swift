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
    let users: DatabaseReference = FirebaseRef.child("users")
    let grupos: DatabaseReference = FirebaseRef.child("grupos")
    var musicosFiltrados: [Musico] = []
    var serenatasContratadas: [String] = ["Reserva con Fecha 30/06/2016 grupo Los Galgos",
                                          "Reserva con Fecha 08/04/2016 grupo Canarios Verdes",
                                          "Reserva Inmediata 25/02/2016 grupo La Lukita",
                                          "Reserva con Fecha 15/01/2016 grupo Santino y Los Churros",
                                          "Reserva Inmediata 24/12/2015 grupo Las Lindas",
                                          "Reserva con Fecha 21/06/2015 grupo Guapo Gimenez",
                                          "Reserva con Fecha 15/04/2015 grupo Andina",
                                          "Reserva con Fecha 01/02/2015 grupo Rockazilla",
                                          "Reserva con Fecha 15/06/2014 grupo Mandragora",
                                          "Reserva con Fecha 15/06/2014 grupo Los Sultanes",
                                          ]
    //var mensajes: [JLMessage]? = nil

    override init() {
        users.keepSynced(true)
        grupos.keepSynced(true)
        super.init()
    }
    
    static let unistancia = Gerente.init()
    func obtenerUsuario(_ uid: String, finalizar: @escaping (Usuario?) -> ()) {
        /*users.observeEventType(.Value, andPreviousSiblingKeyWithBlock: { (captura, llave) in
            if captura.hasChild(uid) {
                finalizar(Usuario(snapshot: captura.childSnapshotForPath(uid)))
            }
            }) { (error) in
                
        }*/
        users.keepSynced(true)
        users.observe(.value, with: { (captura) in
            if captura.hasChild(uid) {
                let capturaUsuario = captura.childSnapshot(forPath: uid)
                /*capturaUsuario.ref.observeEventType(.Value, withBlock: { (capturaU) in
                    print(capturaU)
                })*/
                if capturaUsuario.hasChild("musico") {
                    if (capturaUsuario.childSnapshot(forPath: "musico").value! as? Int)! == 0 {
                        if capturaUsuario.hasChild("ciudad") {
                            finalizar(Usuario(snapshot: capturaUsuario))
                        }
                    } else {
                        if capturaUsuario.hasChilds("genero", "ciudad", "estrellas") && capturaUsuario.hasChild("voces") {
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
    func obtenerMusico(_ uid: String, finalizar: @escaping (Musico?) -> ()) {
        //let users: DatabaseReference = FirebaseRef.child("users")
        users.observe(.value, with: { (captura) in
            if captura.hasChild(uid) {
                let capturaMusico = captura.childSnapshot(forPath: uid)
                if capturaMusico.hasChild("musico") {
                    if (capturaMusico.childSnapshot(forPath: "musico").value! as? Int)! == 1 {
                        if capturaMusico.hasChilds("genero", "ciudad", "voz", "estrellas") {
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
    func filtrarGrupos(_ condiciones: [ChequeoGrupo]) -> [Musico] {
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
    func filtrarMusicos(_ notificar: @escaping BloqueVoid, condiciones: [ChequeoGrupo]?) /*-> [Musico]*/ {
        musicosFiltrados.removeAll()
        grupos.child("musicos").observe(.value, with: { (captura) in
            for child in captura.children {
                self.obtenerMusico((child as AnyObject).key!!, finalizar: { musico in
                    if !self.musicosFiltrados.contains(musico!) {
                        self.musicosFiltrados.append(musico!)
                    }
                    /*print(self.musicosFiltrados.count)
                    print(captura.childrenCount)*/
                    if UInt(self.musicosFiltrados.count) == captura.childrenCount {
                        notificar()
                    }
                })
            }
        })
    }
    func musicosPor(_ condiciones: inout [ChequeoGrupo], musicos: [Musico]) -> [Musico]? {
        if condiciones.count == 0 {
            return musicos
        } else {
            let filtrado = musicos.filter(condiciones.last!)
            condiciones.popLast()
            return musicosPor(&condiciones, musicos: filtrado)
        }
        //return self.musicosFiltrados.filter(<#T##includeElement: (Musico) throws -> Bool##(Musico) throws -> Bool#>)
    }
}
