//
//  FIRDataSnapshot+Ext.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 12/10/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

//import Foundation
extension FIRDataSnapshot {
    func hasChilds(orphans: String...) -> Bool {
        var hasAll = false
        for orp in orphans {
            hasAll = hasChild(orp)
        }
        return hasAll
    }
}