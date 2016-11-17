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
                (!sexo.isEmpty && sexo != "AMBOS" && sexo != "NINGUNO") || (estrellasFiltradas > 0)
            return result
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldString = textField.text ?? ""
        let startIndex = oldString.characters.index(oldString.startIndex, offsetBy: range.location)
        let endIndex = index(startIndex, offsetBy: range.length)
        let newString = oldString.replacingCharacters(
            in: startIndex ..< endIndex, with: string)
        
        if textField == campoCiudad {
            textosFiltrantes["ciudad"] = newString
        } else if textField == campoGenero {
            textosFiltrantes["genero"] = newString
        }
        
        actualizarFiltrados()
        
        return true
    }
}
