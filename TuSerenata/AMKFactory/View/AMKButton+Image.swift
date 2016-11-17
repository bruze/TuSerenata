//
//  AMKButton+Image.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/6/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit

extension AMKButton {
    @IBInspectable weak var defaultImage: UIImage? {
        get {
            return getProperty("defaultImage", initial: nil)
        }
        set {
            setValue(newValue, forProperty: "defaultImage")
            if defaultImage != nil {
                resetView(imageContainer)
                images[AMKTypeTag.imageDefault] = defaultImage
                imageContainer = UIImageView.init(image: defaultImage!)
                addSubview(imageContainer)
                imageContainer.center = CGPoint.init(x: w / 2, y: h / 2)
            }
        }
    }
    @IBInspectable weak var pressImage: UIImage? {
        get {
            return getProperty("pressImage", initial: nil)
        }
        set {
            setValue(newValue, forProperty: "pressImage")
            images[AMKTypeTag.imagePressed] = pressImage
        }
    }
    @IBInspectable weak var disabledImage: UIImage? {
        get {
            return getProperty("disabledImage", initial: nil)
        }
        set {
            setValue(newValue, forProperty: "disabledImage")
            images[AMKTypeTag.imageDisabled] = disabledImage
        }
    }
    @IBInspectable var imageLeading: CGFloat {
        get {
            return getProperty("imageLeading", initial: 0)
        }
        set {
            setValue(newValue, forProperty: "imageLeading")
            imageContainer.center.x = w / 2 + imageLeading
        }
    }
    @IBInspectable var imageYOffset: CGFloat {
        get {
            return getProperty("imageYOffset", initial: 0)
        }
        set {
            setValue(newValue, forProperty: "imageYOffset")
            imageContainer.center.y = h / 2 + imageYOffset
        }
    }
    var imageContainer: UIImageView {
        get {
            return getProperty("imageContainer", initial: UIImageView.init())
        }
        set {
            setValue(newValue, forProperty: "imageContainer")
        }
    }
    internal func addImageViewWith(Image image: UIImage?, AndTag tag: AMKTypeTag) {
        guard image != nil else {
            return
        }
        let imageV = UIImageView.init(image: image)
        imageV.tag = tag.rawValue
        addSubview(imageV)
        imageV.center = CGPoint.init(x: w / 2, y: h / 2)
        setNeedsLayout()
    }
    internal func getImage(ForTag tag: AMKTypeTag) -> UIImage? {
        var image: UIImage? = nil
        switch tag {
        case .default:
            image = nil
        case .currentImage:
            image = nil
        case .imageDefault:
            image = images[tag]
        case .imageDisabled:
            image = images[tag]
        case .imagePressed:
            image = images[tag]
        case .labelDefault:
            image = nil
        }
        return image
    }
    internal func setImage(ForTag tag: AMKTypeTag) {
        if let toSet = getImage(ForTag: tag) {
            resetView(imageContainer)
            imageContainer = UIImageView.init(image: toSet)
            addSubview(imageContainer)
            imageContainer.center = CGPoint.init(x: w / 2 + imageLeading, y: h / 2 + imageYOffset)
        }
    }
}
