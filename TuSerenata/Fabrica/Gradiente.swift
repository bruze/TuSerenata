//
//  Gradiente.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/16/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
import PropertyExtensions

@IBDesignable
class Gradiente: UIView {
    var capaGradiente: CAGradientLayer {
        get {
            return getProperty("capaGradiente", initial: CAGradientLayer.init())
        }
        set {
            setValue(newValue, forProperty: "capaGradiente")
        }
    }
    @IBInspectable var gradienteInicial: UIColor {
        get {
            return getProperty("gradienteInicial", initial: UIColor.clearColor())
        }
        set {
            setValue(newValue, forProperty: "gradienteInicial")
            if !gradienteFinal.isEmpty() {
                tryShowGradient()
            }
        }
    }
    
    @IBInspectable var gradienteFinal: UIColor {
        get {
            return getProperty("gradienteFinal", initial: UIColor.clearColor())
        }
        set {
            setValue(newValue, forProperty: "gradienteFinal")
            if !gradienteInicial.isEmpty() {
                tryShowGradient()
            }
        }
    }
    
    internal func tryShowGradient() {
        capaGradiente = CAGradientLayer()
        //capaGradiente.removeFromSuperlayer()
        capaGradiente.colors = [gradienteInicial.CGColor, gradienteFinal.CGColor]
        capaGradiente.locations = [0.0, 1.0]
        capaGradiente.startPoint = CGPoint(x: 0.0, y: 1.0)
        capaGradiente.endPoint = CGPoint(x: 1.0, y: 1.0)
        capaGradiente.frame = CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height)
        //backgroundColor = UIColor.clearColor()
        layer.insertSublayer(capaGradiente, atIndex: 0)
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
