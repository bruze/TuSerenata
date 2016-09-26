//
//  Login+TextField.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/26/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

//import Foundation
extension Login: UITextFieldDelegate {
    func otroCampo(unCampo: UITextField) -> UITextField {
        return unCampo == campoNombre ? campoContrasena : campoNombre
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let txtW = textField.bounds.size.width
        let strL = string.length
        let strLCero = strL == 0
        if strLCero {
            if txtW - 3 > 96 {
                textField.bounds.size.width -= 3
            }
        } else {
            let resta = view.w - 59
            if txtW + 3 < resta {
                textField.bounds.size.width += 3
            }
        }
        
        botonEntrar.enabled = strLCero ? textField.text!.length - 1 > 0 && otroCampo(textField).text!.length > 0 : otroCampo(textField).text!.length > 0

        return true
    }
}






/*
 
 @available(iOS 2.0, *)
 optional public func textFieldShouldBeginEditing(textField: UITextField) -> Bool // return NO to disallow editing.
 @available(iOS 2.0, *)
 optional public func textFieldDidBeginEditing(textField: UITextField) // became first responder
 @available(iOS 2.0, *)
 optional public func textFieldShouldEndEditing(textField: UITextField) -> Bool // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
 @available(iOS 2.0, *)
 optional public func textFieldDidEndEditing(textField: UITextField) // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
 
 @available(iOS 2.0, *)
 optional public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool // return NO to not change text
 
 @available(iOS 2.0, *)
 optional public func textFieldShouldClear(textField: UITextField) -> Bool // called when clear button pressed. return NO to ignore (no notifications)
 @available(iOS 2.0, *)
 optional public func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
 
 
 */