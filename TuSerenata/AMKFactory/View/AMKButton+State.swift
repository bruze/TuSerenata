//
//  AMKButton+State.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 10/10/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import AssociatedValues

extension AMKButton {
    @IBInspectable var selectable: Bool {
        get {
            return getAssociatedValue(key: "selectable", object: self, initialValue: true)
        }
        set {
            set(associatedValue: newValue, key: "selectable", object: self)
        }
    }
    var selected: Bool {
        get {
            return getAssociatedValue(key: "selected", object: self, initialValue: false)
        }
        set {
            set(associatedValue: newValue, key: "selected", object: self)
        }
    }
}
