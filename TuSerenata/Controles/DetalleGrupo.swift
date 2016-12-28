//
//  DetalleGrupo.swift
//  TuSerenata
//
//  Created by Bruce on 14/12/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
class DetalleGrupo: ViewController {
    
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var genero: UILabel!
    @IBOutlet weak var ciudad: UILabel!
    @IBOutlet weak var voces: UILabel!
    @IBOutlet weak var bio: UITextView!
    @IBOutlet weak var imagen: UIImageView!
    
    var grupo: Musico?
    override func viewDidLoad() {
        if let unwrpdGr = grupo {
            nombre.text = unwrpdGr.nombre
            genero.text = unwrpdGr.genero
            ciudad.text = unwrpdGr.ciudad
            voces.text = unwrpdGr.voz
        }
    }
}
