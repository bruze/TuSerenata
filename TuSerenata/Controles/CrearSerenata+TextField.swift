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
    /*func textFieldDidEndEditing(textField: UITextField) {
        
    }*/
}
