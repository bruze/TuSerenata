//
//  CrearSerenata+TextField.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/29/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
extension CrearSerenata: UITextFieldDelegate {
    internal var filtrando: Bool {
        get {
            let result = !(campoCiudad.text?.isEmpty())! || !(campoGenero.text?.isEmpty())!
            return result
        }
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        actualizarFiltrados()
        
        return true
    }
    func textFieldDidEndEditing(textField: UITextField) {
        actualizarFiltrados()
    }
    func textFieldShouldClear(textField: UITextField) -> Bool {
        actualizarFiltrados()
        
        return true
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        actualizarFiltrados()
    }
    /*func textFieldDidEndEditing(textField: UITextField) {
        
    }*/
}
