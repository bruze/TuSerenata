//
//  AMKButton+State.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 10/10/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

//import Foundation
extension AMKButton {
    @IBInspectable var selectable: Bool {
        get {
            return getProperty("selectable", initial: true)
        }
        set {
            setValue(newValue, forProperty: "selectable")
        }
    }
    var selected: Bool {
        get {
            return getProperty("selected", initial: false)
        }
        set {
            setValue(newValue, forProperty: "selected")
        }
    }
}