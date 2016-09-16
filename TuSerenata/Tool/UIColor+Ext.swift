//
//  UIColor+Ext.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/16/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit

extension UIColor {
    func isEmpty() -> Bool {
        return self == UIColor.clearColor()
    }
}
