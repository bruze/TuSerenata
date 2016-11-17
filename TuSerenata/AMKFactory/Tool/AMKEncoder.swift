//
//  AMKEncoder.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/8/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
//import SwiftFilePath
import AssociatedValues

@objc protocol AMKEncodable {
    var storeID: String {get set}
    func encode()
    func decode(_ data: NSDictionary)
}

extension UIView: AMKEncodable/*, PropertyExtensions*/ {
    /*@IBInspectable public var storeID: String {
        get {
            return getProperty("storeID", initial:"")
        }
        set {
            setValue(newValue, forProperty: "storeID")
        }
    }
    var defaultLabel: String {
        get {
            return getProperty("defaultLabel", initial:"")
        }
        set {
            setValue(newValue, forProperty: "defaultLabel")
        }
    }*/
    @IBInspectable public var storeID: String {
        get {
            return getAssociatedValue(key: "storeID", object: self, initialValue: {return ""})
        }
        set {
            backStoreID = storeID
            set(associatedValue: newValue, key: "storeID", object: self)
        }
        
    }
    public var backStoreID: String {
        get {
            return getAssociatedValue(key: "backStoreID", object: self, initialValue: {return ""})
        }
        set {
            set(associatedValue: newValue, key: "backStoreID", object: self)
        }
        
    }
    var storeLoaded: Bool {
        get {
            return getAssociatedValue(key: "storeLoaded", object: self, initialValue: {return false})
        }
        set {
            set(associatedValue: newValue, key: "storeLoaded", object: self)
        }
    }
    var defaultLabel: String {
        get {
            return getAssociatedValue(key: "defaultLabel", object: self, initialValue: {return ""})
        }
        set {
            set(associatedValue: newValue, key: "defaultLabel", object: self)
        }
    }
    func encode() {
        
    }
    func decode(_ data: NSDictionary) {
        
    }
    /*func encode() {
        let textFile = Path.documentsDir[storeID + ".txt"]
        let dataToWrite = ">".join(["class", className + "\n"]) +
                          ">".join(["frame", frame.toString() + "\n"]) +
                          ">".join(["label", defaultLabel + "\n"])
        textFile.writeString(dataToWrite)
    }
    func decode() {
        guard !storeID.isEmpty else {
            return
        }
        #if !TARGET_INTERFACE_BUILDER
            let textFile = Path.documentsDir[storeID + ".txt"]
        #else
            let textFile = Path.init("/Users/bgarelli/Library/Developer/CoreSimulator/Devices/" +
                "AAF9BE99-DC9E-4822-8C6B-F6E31DCBE133/data/Containers/Data/Application/8C70B497-5042-4E58-89A0-57A541C818D0/Documents/" + storeID + ".txt")
        #endif

        if textFile.readString() != nil {
            var dataToRead = textFile.readString()!
            /*var index = dataToRead.indexOf("class>")
             let className = dataToRead.substring(index! + 6, length: dataToRead.indexOf("\n")! - 6)*/
            dataToRead.readLine().readStoredValue("class")
            let stringframe = dataToRead.readLine().readStoredValue("frame")
            let reconstructedFrame = CGRect.loadFromString(stringframe)
            self.frame = reconstructedFrame
            defaultLabel = dataToRead.readLine().readStoredValue("label")
        }
    }*/
}
