//
//  AMKButton+Navigation.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 10/10/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import AssociatedValues
extension AMKButton {
    @IBOutlet weak var previousSibling: AMKButton? {
        get {
            return getAssociatedValue(key: "previousSibling", object: self, initialValue: nil)
        }
        set {
            set(associatedValue: newValue, key: "previousSibling", object: self)
        }
    }
    @IBOutlet weak var nextSibling: AMKButton? {
        get {
            return getAssociatedValue(key: "nextSibling", object: self, initialValue: nil)
        }
        set {
            set(associatedValue: newValue, key: "nextSibling", object: self)
        }
    }
    func performOnPreviousSibling(Block block: BloqueBoton) {
        previousSibling?.performOnMeAndPreviousSibling(Block: block)
    }
    func performOnMeAndPreviousSibling(Block block: BloqueBoton) {
        block(self)
        previousSibling?.performOnMeAndPreviousSibling(Block: block)
    }
    func performOnNextSibling(Block block: BloqueBoton) {
        nextSibling?.performOnMeAndNextSibling(Block: block)
    }
    func performOnMeAndNextSibling(Block block: BloqueBoton) {
        block(self)
        nextSibling?.performOnMeAndNextSibling(Block: block)
    }
}
