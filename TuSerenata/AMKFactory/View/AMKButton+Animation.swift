//
//  AMKButton+Animation.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/13/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
typealias Move = Global.RLMove
extension AMKButton {
    @IBInspectable var showPassAtTap: Bool {
        get {
            return getProperty("showPassAtTap", initial: false)
        }
        set {
            setValue(newValue, forProperty: "showPassAtTap")
        }
    }
    var lastMove: Move {
        get {
            return getProperty("lastMove", initial: .Left)
        }
        set {
            setValue(newValue, forProperty: "lastMove")
        }
    }
    var layerLoaded: Bool {
        get {
            return getProperty("layerLoaded", initial: false)
        }
        set {
            setValue(newValue, forProperty: "layerLoaded")
        }
    }
    var animLayer: CALayer {
        get {
            let pLayer = getProperty("animLayer", initial: emptyLayer)
            if !layerLoaded {
                pLayer.frame = bounds
                pLayer.contentsRect = bounds
                pLayer.position = CGPoint.init(x: pLayer.position.x - bounds.width, y: pLayer.position.y)
                layer.addSublayer(pLayer)
                self.animLayer = pLayer
                layerLoaded = true
            }
            return pLayer
        }
        set {
            setValue(newValue, forProperty: "animLayer")
        }
    }
    func passingLayerColor(_ color: UIColor, GoingRight right: Bool) {
        animLayer.backgroundColor = color.cgColor
        let animation = CABasicAnimation.init(keyPath: "position.x")
        animation.duration = 0.4
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        if lastMove == .left {
            lastMove = .right
            animation.fromValue = animLayer.position.x
            animation.toValue = animLayer.position.x + bounds.width * 2
        } else {
            lastMove = .left
            animation.fromValue = bounds.width * 2
            animation.toValue = animLayer.position.x - bounds.width
        }
        let sizeAnim = CABasicAnimation.init(keyPath: "bounds.width")
        if lastMove == .left {
            sizeAnim.fromValue = 0
            sizeAnim.toValue = bounds.width
        } else {
            sizeAnim.fromValue = bounds.w
            sizeAnim.toValue = 0
        }
        animLayer.add(animation, forKey: "position.x")
        animLayer.add(sizeAnim, forKey: "bounds.width")
    }
}
