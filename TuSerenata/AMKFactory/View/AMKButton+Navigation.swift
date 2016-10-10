//
//  AMKButton+Navigation.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 10/10/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

//import Foundation
extension AMKButton {
    @IBOutlet weak var previousSibling: AMKButton? {
        get {
            return getProperty("previousSibling", initial: nil)
        }
        set {
            setValue(newValue, forProperty: "previousSibling")
        }
    }
    @IBOutlet weak var nextSibling: AMKButton? {
        get {
            return getProperty("nextSibling", initial: nil)
        }
        set {
            setValue(newValue, forProperty: "nextSibling")
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