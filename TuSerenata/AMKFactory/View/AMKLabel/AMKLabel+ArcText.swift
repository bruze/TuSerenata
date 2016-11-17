//
//  AMKLabel+ArcText.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/28/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
extension AMKLabel {
    override func draw(_ rect: CGRect) {
        /*guard let _ = label else {
            print("NO LABEL")
            return
        }*/
        #if TARGET_INTERFACE_BUILDER
            let size = frame.size//CGSize.init(width: 256, height: 256)
        #else
            let size = rect.size
        #endif
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        let context = UIGraphicsGetCurrentContext()!
        // *******************************************************************
        // Scale & translate the context to have 0,0
        // at the centre of the screen maths convention
        // Obviously change your origin to suit...
        // *******************************************************************
        var tHeight = size.height / 2
        if curve {
            tHeight += 30
        }
        context.translateBy (x: size.width / 2, y: tHeight)
        context.scaleBy (x: 1, y: -1)
        context.setFillColor(UIColor.clear.cgColor)
        context.fill(bounds)
        
        /*centreArcPerpendicularText("Hello round world", context: context, radius: 100, angle: 0, colour: UIColor.redColor(), font: UIFont.systemFontOfSize(16), clockwise: true)
        centreArcPerpendicularText("Anticlockwise", context: context, radius: 100, angle: CGFloat(-M_PI_2), colour: UIColor.redColor(), font: UIFont.systemFontOfSize(16), clockwise: false)
        centreText("Hello flat world", context: context, radius: 0, angle: 0 , colour: UIColor.yellowColor(), font: UIFont.systemFontOfSize(16), slantAngle: CGFloat(M_PI_4))*/
        /*centreArcPerpendicularText(label!.text!, context: context, radius: 40 + label!.curveRadius, angle: label!.curveAngle.degreesToRadians(), colour: label!.textColor, font: label!.font, clockwise: label!.curveClockwise)*/
        let drawText: String = overrideStoredText ? overrideText : text
        if curve {
            centreArcPerpendicularText(drawText, context: context, radius: 40 + curveRadius, angle: /*CGFloat(-135)*/curveAngle.degreesToRadians(), colour: textColor, font: textFont, clockwise: curveClockwise)
        } else {
            centreText(drawText, context: context, radius: 0, angle: 180, colour: textColor, font: textFont, slantAngle: 0)
        }
        
        
        
        /*centreArcPerpendicularText(text!, context: context, radius: 40 + curveRadius, angle: curveAngle.degreesToRadians(), colour: textColor, font: font, clockwise: curveClockwise)*/
        
        removeSubviews()
        addSubview(UIImageView.init(image: UIGraphicsGetImageFromCurrentImageContext()))
        UIGraphicsEndImageContext()
    }
    
    func centreArcPerpendicularText(_ str: String, context: CGContext, radius r: CGFloat, angle theta: CGFloat, colour c: UIColor, font: UIFont, clockwise: Bool){
        // *******************************************************
        // This draws the String str around an arc of radius r,
        // with the text centred at polar angle theta
        // *******************************************************
        
        let l = str.characters.count
        let attributes = [NSFontAttributeName: font]
        
        var characters: [String] = [] // This will be an array of single character strings, each character in str
        var arcs: [CGFloat] = [] // This will be the arcs subtended by each character
        var totalArc: CGFloat = 0 // ... and the total arc subtended by the string
        
        // Calculate the arc subtended by each letter and their total
        for i in 0 ..< l {
            characters += [String(str[str.characters.index(str.startIndex, offsetBy: i)])]
            arcs += [chordToArc(characters[i].size(attributes: attributes).width, radius: r)]
            totalArc += arcs[i]
        }
        
        // Are we writing clockwise (right way up at 12 o'clock, upside down at 6 o'clock)
        // or anti-clockwise (right way up at 6 o'clock)?
        let direction: CGFloat = clockwise ? -1 : 1
        let slantCorrection = clockwise ? -CGFloat(M_PI_2) : CGFloat(M_PI_2)
        
        // The centre of the first character will then be at
        // thetaI = theta - totalArc / 2 + arcs[0] / 2
        // But we add the last term inside the loop
        var thetaI = theta - direction * totalArc / 2
        
        for i in 0 ..< l {
            thetaI += direction * arcs[i] / 2
            // Call centerText with each character in turn.
            // Remember to add +/-90º to the slantAngle otherwise
            // the characters will "stack" round the arc rather than "text flow"
            centreText(characters[i], context: context, radius: r, angle: thetaI, colour: c, font: font, slantAngle: thetaI + slantCorrection)
            // The centre of the next character will then be at
            // thetaI = thetaI + arcs[i] / 2 + arcs[i + 1] / 2
            // but again we leave the last term to the start of the next loop...
            thetaI += direction * arcs[i] / 2
        }
    }
    
    func chordToArc(_ chord: CGFloat, radius: CGFloat) -> CGFloat {
        // *******************************************************
        // Simple geometry
        // *******************************************************
        return 2 * asin(chord / (2 * radius))
    }
    
    func centreText(_ str: String, context: CGContext, radius r:CGFloat, angle theta: CGFloat, colour c: UIColor, font: UIFont, slantAngle: CGFloat) {
        // *******************************************************
        // This draws the String str centred at the position
        // specified by the polar coordinates (r, theta)
        // i.e. the x= r * cos(theta) y= r * sin(theta)
        // and rotated by the angle slantAngle
        // *******************************************************
        
        // Set the text attributes
        let attributes = [NSForegroundColorAttributeName: c,
                          NSFontAttributeName: font]
        // Save the context
        context.saveGState()
        // Undo the inversion of the Y-axis (or the text goes backwards!)
        context.scaleBy(x: 1, y: -1)
        // Move the origin to the centre of the text (negating the y-axis manually)
        context.translateBy(x: r * cos(theta), y: -(r * sin(theta)))
        // Rotate the coordinate system
        context.rotate(by: -slantAngle)
        // Calculate the width of the text
        let offset = str.size(attributes: attributes)
        // Move the origin by half the size of the text
        context.translateBy (x: -offset.width / 2, y: -offset.height / 2) // Move the origin to the centre of the text (negating the y-axis manually)
        // Draw the text
        str.draw(at: CGPoint.zero, withAttributes: attributes)
        // Restore the context
        context.restoreGState()
    }
}
