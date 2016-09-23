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
    
    var botonCompra: AMKButton {
        get {
            return (view.viewWithTag(1)! as? AMKButton)!
        }
    }
    
    override func viewDidLoad() {
        botonCompra.addBlock({}, ForAction: 0)
    }
}
