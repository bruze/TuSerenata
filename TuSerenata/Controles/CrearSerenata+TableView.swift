//
//  CrearSerenata+TableView.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/23/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit

extension CrearSerenata: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        
        if gruposBuscados.count > 0 && filtrando && indexPath.row < gruposBuscados.count {
            grupoSeleccionado = gruposBuscados[indexPath.row]
        } else if gerente.musicosFiltrados.count > 0 && indexPath.row < gerente.musicosFiltrados.count {
            grupoSeleccionado = gerente.musicosFiltrados[indexPath.row]
        }
        
        performSegue(withIdentifier: "irDetalleGrupo", sender: nil)
    }
}

extension CrearSerenata: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if /*gruposBuscados.count > 0 ||*/ filtrando {
           return gruposBuscados.count
        }
        return gerente.musicosFiltrados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "")
        if gruposBuscados.count > 0 && filtrando && indexPath.row < gruposBuscados.count {
            cell.textLabel?.text = gruposBuscados[indexPath.row].nombre
        } else if gerente.musicosFiltrados.count > 0 && indexPath.row < gerente.musicosFiltrados.count {
            cell.textLabel?.text = gerente.musicosFiltrados[indexPath.row].nombre
        }
        return cell
    }
}
