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
            let result = !(textosFiltrantes["ciudad"]!.isEmpty()) || !(textosFiltrantes["genero"]!.isEmpty()) ||
                (!sexo.isEmpty && sexo != "AMBOS" && sexo != "NINGUNO")
            return result
        }
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldString = textField.text ?? ""
        let startIndex = oldString.startIndex.advancedBy(range.location)
        let endIndex = startIndex.advancedBy(range.length)
        let newString = oldString.stringByReplacingCharactersInRange(
            startIndex ..< endIndex, withString: string)
        
        if textField == campoCiudad {
            textosFiltrantes["ciudad"] = newString
        } else if textField == campoGenero {
            textosFiltrantes["genero"] = newString
        }
        
        actualizarFiltrados()
        
        return true
    }
}
