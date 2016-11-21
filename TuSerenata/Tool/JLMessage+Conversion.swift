//
//  JLMessage+Conversion.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/23/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import Foundation
import JLChatViewController
import AssociatedValues

extension JLMessage/*: PropertyExtensions*/ {
    static func desdeCaptura(_ captura: FIRDataSnapshot) -> JLMessage {
        let dict = anytool.dicstrany(any: captura.value!)
        let texto = (dict["mensaje"] as? String)!
        let enviadoPor = (dict["enviadoPor"] as? String)!
        let mensaje = JLMessage.init(text: texto, senderID: enviadoPor, messageDate: NSDate.init() as Date, senderImage: nil)
        return mensaje
    }
    
    func toAnyObject() -> AnyObject {
        return 1 as AnyObject
    }
}
