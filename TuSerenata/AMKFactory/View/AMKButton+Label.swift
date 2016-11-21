//
//  AMKButton+Label.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/5/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
import AssociatedValues

extension AMKButton {
    @IBInspectable var autoCenter: Bool {
        get {
            return getAssociatedValue(key: "autoCenter", object: self, initialValue: {return false}())
        }
        set {
            set(associatedValue: newValue, key: "autoCenter", object: self)
            currentDefaultLabel?.center = CGPoint.init(x: w / 2, y: h / 2)
        }
    }
    var currentDefaultLabel: UILabel? {
        get {
            if let view = viewWithTag(AMKTypeTag.labelDefault.rawValue) {
                return view as? UILabel
            }
            return nil
        }
    }
    @IBInspectable override var defaultLabel: String {
        didSet {
            resetView(currentDefaultLabel)
            if !defaultLabel.isEmpty {
                addLabelWith(Text: defaultLabel, AndOffset: CGPoint.zero)
            }
        }
    }
    @IBInspectable var defLabelXOffset: CGFloat {
        get {
            return getAssociatedValue(key: "defLabelXOffset", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "defLabelXOffset", object: self)
            currentDefaultLabel?.origin = CGPoint.init(x: defLabelXOffset, y: defLabelYOffset)
            /*if labelRelativeImage == 0 {
                //currentDefaultLabel?.origin.x += defLabelXOffset
            } else {
                //print(labelRelativeImage)
            }*/
        }
    }
    @IBInspectable var defLabelYOffset: CGFloat {
        get {
            return getAssociatedValue(key: "defLabelYOffset", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "defLabelYOffset", object: self)
            currentDefaultLabel?.origin = CGPoint.init(x: defLabelXOffset, y: defLabelYOffset)
            /*if labelRelativeImage == 0 {
             currentDefaultLabel?.origin.y += defLabelYOffset
             } else {
             //print(labelRelativeImage)
             }*/
        }
    }
    @IBInspectable var labelFontColor: UIColor {
        get {
            return getAssociatedValue(key: "labelFontColor", object: self, initialValue: UIColor.black)
        }
        set {
            set(associatedValue: newValue, key: "labelFontColor", object: self)
            currentDefaultLabel?.textColor = newValue
        }
    }

    @IBInspectable var labelFontName: String {
        get {
            return getAssociatedValue(key: "labelFontName", object: self, initialValue: "")
        }
        set {
            set(associatedValue: newValue, key: "labelFontName", object: self)
            let font = UIFont.init(name: newValue, size: labelFontSize)
            currentDefaultLabel?.font = font
        }
    }

    @IBInspectable var labelFontSize: CGFloat {
        get {
            return getAssociatedValue(key: "labelFontSize", object: self, initialValue: 16)
        }
        set {
            set(associatedValue: newValue, key: "labelFontSize", object: self)
            let font = UIFont.init(name: labelFontName, size: newValue)
            currentDefaultLabel?.font = font
        }
    }
    internal func addLabelWith(Text labelText: String, AndOffset offset: CGPoint) {
        let setW = w //- (w/6)
        let setH = h //- (h / 4)
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, w: setW, h: setH))
        label.textAlignment = .center
        label.tag = AMKTypeTag.labelDefault.rawValue
        label.text = labelText
        addSubview(label)
        label.layer.zPosition = 1000
        if autoCenter {
            //label.origin = CGPoint.init(x: 10, y: 0)
            label.center = CGPoint.init(x: setW + 15, y: setH)
        } else {
            label.origin = CGPoint.init(x: defLabelXOffset, y: defLabelYOffset)
        }
        label.centerYInSuperView()
        /*if let image = currentImage where labelRelativeImage != 0 {
            currentDefaultLabel?.origin.x = image.origin.x + image.w + labelRelativeImage
        }*/
        //updateViews()
    }
}
