//
//  AMKEncoder.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/8/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
//import SwiftFilePath
import PropertyExtensions

@objc protocol AMKEncodable {
    var storeID: String {get set}
    func encode()
    func decode()
}

extension UIView: /*AMKEncodable,*/ PropertyExtensions {
    @IBInspectable public var storeID: String {
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
