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
    @IBOutlet var botonestrellas: [AMKButton]!
    var textosFiltrantes: [String: String] = ["ciudad":"","genero":"","voz":""]
    var filtros: [ChequeoGrupo] = []
    var gruposBuscados: [Musico] = []
    var sexo: String {
        get {
            var resultado = "NINGUNO"
            if botonF.selected {
                if botonM.selected {
                    resultado = "AMBOS"
                    //return "AMBOS"
                } else {
                    resultado = "F"
                    //return "F"
                }
            } else if botonM.selected {
                resultado = "M"
                //return "M"
            }
            //var array: [ChequeoGrupo] = []
            //print(gerente.musicosPor(&array, musicos: gerente.musicosFiltrados))
            return resultado
            //return "NINGUNO"
        }
    }
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
    var botonF: AMKButton {
        get {
            return (view.viewWithTag(4)! as? AMKButton)!
        }
    }
    var botonM: AMKButton {
        get {
            return (view.viewWithTag(5)! as? AMKButton)!
        }
    }
    var estrellasFiltradas: Int {
        get {
            return botonestrellas.filter { (button) -> Bool in
                return button.selected
            }.count
        }
    }
    override func viewDidLoad() {
        cargarFiltros()
        botonCompra.addBlock({}, ForAction: 0)
        /*botonBuscar.addBlock({ self.gruposBuscados = gerente.filtrarGrupos([{ musico in
            let resultado = musico.genero.lowercaseString.contains(self.campoGenero.text!.lowercaseString)
            return resultado || self.campoGenero.text!.isEmpty()
            }, { musico in
                 let resultado = musico.ciudad.lowercaseString.contains(self.campoCiudad.text!.lowercaseString)
                 return resultado || self.campoCiudad.text!.isEmpty()
            }]) }, ForAction: 0)
        botonBuscar.addBlock({ self.tableView.reloadData() }, ForAction: 1)*/
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //menuView.commitMenuViewUpdate()
        calendario.commitCalendarViewUpdate()
    }
    func filtroEstrellas(boton: AnyObject) {
        let amkButton = (boton as? AMKButton)!
        if amkButton.selected && amkButton.previousSibling == nil {
            amkButton.backgroundColor = amkButton.defaultBackColor
        } else {
            amkButton.backgroundColor = UIColor.yellowColor()
            if amkButton.selected {
                amkButton.selected.toggle()
            }
            amkButton.performOnPreviousSibling { (but) in
                but.backgroundColor = UIColor.yellowColor()
                but.selected = true
            }
        }
        amkButton.performOnNextSibling { (but) in
            but.backgroundColor = but.defaultBackColor
            but.selected = false
        }
    }
    func seleccionGenero(boton: AnyObject) {
        if (boton as? AMKButton)!.selected {
            (boton as? AMKButton)!.labelFontColor = UIColor.whiteColor()
        } else {
            (boton as? AMKButton)!.labelFontColor = UIColor.blackColor()
        }
        actualizarFiltrados()
        //print(estrellasFiltradas)
    }
    internal func cargarFiltros() {
        //GENERO MUSICAL
        filtros.append({ musico in
            let resultado = musico.genero.lowercaseString.contains(self.textosFiltrantes["genero"]!.lowercaseString)
            return resultado || self.campoGenero.text!.isEmpty()
        })
        //CIUDAD
        filtros.append({ musico in
            let resultado = musico.ciudad.lowercaseString.contains(self.textosFiltrantes["ciudad"]!.lowercaseString)
            return resultado || self.campoCiudad.text!.isEmpty()
        })
        //VOCES
        filtros.append({ musico in
            let resultado = musico.voz.lowercaseString.contains(self.sexo.lowercaseString)
            return resultado || self.sexo == "NINGUNO" || self.sexo == "AMBOS"
        })
        //ESTRELLAS
        filtros.append({ musico in
            let resultado = musico.estrellas == self.estrellasFiltradas
            return resultado || self.estrellasFiltradas == 0
        })
        
    }
    internal func actualizarFiltrados() {
        self.gruposBuscados = gerente.filtrarGrupos(filtros)
        tableView.reloadData()
    }
}

extension CrearSerenata: CVCalendarViewDelegate {
    func didSelectDayView(dayView: DayView, animationDidFinish: Bool) {
        print(dayView.dayLabel.text)
    }
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    func firstWeekday() -> Weekday {
        return .Sunday
    }
}