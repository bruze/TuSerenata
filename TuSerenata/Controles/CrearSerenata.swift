//
//  CrearSerenata.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/23/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
import CVCalendar

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
    var calendario: CVCalendarView {
        get {
            return (view.viewWithTag(3)! as? CVCalendarView)!
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
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //menuView.commitMenuViewUpdate()
        calendario.commitCalendarViewUpdate()
    }
    func filtroEstrellas(boton: AnyObject) {
        (boton as? AMKButton)!.performOnMeAndPreviousSibling { (self) in
            self.backgroundColor = UIColor.yellowColor()
        }
        (boton as? AMKButton)!.performOnNextSibling { (self) in
            self.backgroundColor = self.defaultBackColor
        }
    }
}

extension CrearSerenata: CVCalendarViewDelegate {
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    func firstWeekday() -> Weekday {
        return .Sunday
    }
}