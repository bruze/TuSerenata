//
//  UIViewController+Ext.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/22/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import AssociatedValues

import UCZProgressView

extension UIViewController/*: PropertyExtensions*/ {
    internal var cargando: UCZProgressView {
        get {
            return getAssociatedValue(key: "cargando", object: self, initialValue: cargaVacia)
        }
        set {
            set(associatedValue: newValue, key: "cargando", object: self)
        }
    }
    internal var capa: UIView {
        get {
            return getAssociatedValue(key: "capa", object: self, initialValue: UIView.init())
        }
        set {
            set(associatedValue: newValue, key: "capa", object: self)
        }
    }
    internal var popup: UIView {
        get {
            return getAssociatedValue(key: "popup", object: self, initialValue: UIView.init())
        }
        set {
            set(associatedValue: newValue, key: "popup", object: self)
        }
    }
    internal func toqueHijosAceptado(_ aceptado: Bool) {
        view.subviews.forEach { (vista) in
            vista.1.isUserInteractionEnabled = aceptado
        }
    }
    internal func opacarFondo() {
        toqueHijosAceptado(false)
        capa = UIView.init(frame: view.frame)
        capa.backgroundColor = UIColor.black
        capa.alpha = 0.6
        view.addSubview(capa)
        capa.becomeFirstResponder()
    }
    internal func fondoNormal() {
        capa.removeFromSuperview()
        popup.removeFromSuperview()
        toqueHijosAceptado(true)
    }
    internal func ventanaEmergente(_ datos: DicStrStr, acciones: [BloqueVoid]) {
        opacarFondo()

        popup = UIView.init(frame: CGRect.init(x: 0, y: 0, w: 200, h: 150))
        popup.backgroundColor = UIColor.white
        popup.isOpaque = true
        
        let button1 = AMKButton.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 120, height: 60))).addBlock(acciones[0], ForAction: 0).addBlock({self.fondoNormal()}, ForAction: 1)
        button1.defaultLabel = datos["acc1"]!
        
        let button2 = AMKButton.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 120, height: 60))).addBlock(acciones[1], ForAction: 0).addBlock({self.fondoNormal()}, ForAction: 1)
        button2.defaultLabel = datos["acc2"]!
        
        popup.addSubview(button1)
        popup.addSubview(button2)
        button2.origin.y += 75
        view.addSubview(popup)
        popup.centerInSuperView()
    }
    //MARK:CARGA
    func mostrarCarga() {
        cargando = UCZProgressView.init(frame: view.frame)
        cargando.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cargando)
    }
    func ocultarCarga() {
        cargando.removeFromSuperview()
        cargando = cargaVacia
    }
    //MARK:CHAT
    /**
        You must have a segue named "goChat" to get this working
    */
    func openChat() {
        /*let chatSt = UIStoryboard.init(name: "Chat", bundle: nil)
        let initialVC = chatSt.instantiateInitialViewController()
        pushVC(initialVC!)*/
        performSegue(withIdentifier: "goChat", sender: nil)
        /*if let vc = JLBundleController.instantiateJLChatVC() as? ChatVC {
            
            vc.view.frame = self.view.frame
            
            let chatSegue = UIStoryboardSegue(identifier: "goChat", source: self, destination: vc, performHandler: { () -> Void in
                vc.contestatario = gerente.musicosFiltrados[0]
                self.navigationController?.pushViewController(vc, animated: true)
            })
            
            self.prepare(for: chatSegue, sender: nil)
            
            chatSegue.perform()
        }*/
    }
}
