//
//  CrearSerenata+TableView.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/23/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit

extension CrearSerenata: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.selected = false
    }
}

extension CrearSerenata: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if gruposBuscados.count > 0 || filtrando {
           return gruposBuscados.count
        }
        return gerente.musicosFiltrados.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .Default, reuseIdentifier: "")
        if gruposBuscados.count > 0 || filtrando {
            cell.textLabel?.text = gruposBuscados[indexPath.row].nombre
        } else {
            cell.textLabel?.text = gerente.musicosFiltrados[indexPath.row].nombre
        }
        return cell
    }
}
