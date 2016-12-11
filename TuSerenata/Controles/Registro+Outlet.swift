//
//  Registro+Outlet.swift
//  TuSerenata
//
//  Created by Bruce on 6/12/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
import AssociatedValues
extension Registro {
    dynamic var camposUsuario: UIView {
        get {
            return view.viewWithTag(100)!
        }
    }
    dynamic var botonRegistro: AMKButton {
        get {
            return (view.viewWithTag(101) as? AMKButton)!
        }
    }
    dynamic var botonHabilitarUsuario: AMKButton {
        get {
            return (view.viewWithTag(102) as? AMKButton)!
        }
    }
    dynamic var botonHabilitarGrupo: AMKButton {
        get {
            return (view.viewWithTag(103) as? AMKButton)!
        }
    }
}
