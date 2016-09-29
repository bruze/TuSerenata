//
//  CrearSerenata.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/23/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit

class CrearSerenata: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var campoCiudad: UITextField!
    @IBOutlet weak var campoGenero: UITextField!
    var gruposBuscados: [Musico] = []
    var botonCompra: AMKButton {
        get {
            return (view.viewWithTag(1)! as? AMKButton)!
        }
    }
    var botonBuscar: AMKButton {
        get {
            return (view.viewWithTag(2)! as? AMKButton)!
        }
    }
    override func viewDidLoad() {
        botonCompra.addBlock({}, ForAction: 0)
        botonBuscar.addBlock({ self.gruposBuscados = gerente.filtrarGrupos([{ musico in
            let resultado = musico.genero.lowercaseString.contains(self.campoGenero.text!.lowercaseString)
            return resultado || self.campoGenero.text!.isEmpty()
            }, { musico in
                 let resultado = musico.ciudad.lowercaseString.contains(self.campoCiudad.text!.lowercaseString)
                 return resultado || self.campoCiudad.text!.isEmpty()
            }]) }, ForAction: 0)
        botonBuscar.addBlock({ self.tableView.reloadData() }, ForAction: 1)
    }
}
