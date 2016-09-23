//
//  JLMessage+Conversion.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/23/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import Foundation
import JLChatViewController
import PropertyExtensions

extension JLMessage: PropertyExtensions {
    static func desdeCaptura(captura: FIRDataSnapshot) -> JLMessage {
        let texto = (captura.value!["mensaje"] as? String)!
        let enviadoPor = (captura.value!["enviadoPor"] as? String)!
        let mensaje = JLMessage.init(text: texto, senderID: enviadoPor, messageDate: NSDate.init(), senderImage: nil)
        return mensaje
    }
    
    func toAnyObject() -> AnyObject {
        return 1
    }
}