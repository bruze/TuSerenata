//
//  Gradiente.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/16/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
import AssociatedValues

@IBDesignable
class Gradiente: UIView {
    var capaGradiente: CAGradientLayer {
        get {
            return getAssociatedValue(key: "capaGradiente", object: self, initialValue: CAGradientLayer.init())
        }
        set {
            set(associatedValue: newValue, key: "capaGradiente", object: self)
        }
    }
    @IBInspectable var gradienteInicial: UIColor {
        get {
            return getAssociatedValue(key: "gradienteInicial", object: self, initialValue: UIColor.clear)
        }
        set {
            set(associatedValue: newValue, key: "gradienteInicial", object: self)
            if !gradienteFinal.isEmpty() {
                tryShowGradient()
            }
        }
    }
    
    @IBInspectable var gradienteFinal: UIColor {
        get {
            return getAssociatedValue(key: "gradienteFinal", object: self, initialValue: UIColor.clear)
        }
        set {
            set(associatedValue: newValue, key: "gradienteFinal", object: self)
            if !gradienteInicial.isEmpty() {
                tryShowGradient()
            }
        }
    }
    
    internal func tryShowGradient() {
        capaGradiente = CAGradientLayer()
        //capaGradiente.removeFromSuperlayer()
        capaGradiente.colors = [gradienteInicial.cgColor, gradienteFinal.cgColor]
        capaGradiente.locations = [0.0, 1.0]
        capaGradiente.startPoint = CGPoint(x: 0.0, y: 1.0)
        capaGradiente.endPoint = CGPoint(x: 1.0, y: 1.0)
        capaGradiente.frame = CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height)
        //backgroundColor = UIColor.clearColor()
        layer.insertSublayer(capaGradiente, at: 0)
        layoutIfNeeded()
    }
    
    override func didMoveToSuperview() {
        if superview != nil {
            /*centerInSuperView()
            superview!.layoutIfNeeded()
            setNeedsLayout()*/
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        self.initialize()
    }
    func initialize() {
        //decode()
        //addSubview(imageContainer)
        //clipsToBounds = true
    }
}
