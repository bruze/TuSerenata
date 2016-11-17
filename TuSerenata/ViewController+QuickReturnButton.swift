//
//  ViewController+QuickReturnButton.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/22/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//


import UIKit

private let checkpoint: CGPoint  = CGPoint.init(x: 1, y: 1)
private var initialRecognizeButtonHeigth: CGFloat = 0.0

enum FooterAnimation {
    case `default`
    case moving
    case done
    case invalid
    func nextState() -> FooterAnimation {
        switch self {
        case .default:
            return .moving
        case .moving:
            return .done
        case .done:
            return .`default`
        case .invalid:
            return .invalid
        }
    }
    mutating func next() {
        switch self {
        case .default:
            self = .moving
        case .moving:
            self = .done
        case .done:
            self = .`default`
        case .invalid:
            self = .invalid
        }
    }
}

typealias QuickReturnSwiftState = (FooterAnimation, Float, Bool)
typealias QuickReturnResult = (Float, FooterAnimation)
typealias QuickReturnMove = (FooterAnimation) -> QuickReturnResult
typealias QuickReturnParameters = (Bool, Float)
private let thresHold: Float = 10
func quickReturn(_ params: QuickReturnParameters) -> QuickReturnMove {
    return { state in
        let valueSet = params.1
        if params.0 {
            return QuickReturnResult(Float(initialRecognizeButtonHeigth), nextState((state, valueSet, true)))
        } else {
            return QuickReturnResult((valueSet < thresHold ? 0 : valueSet), nextState((state, valueSet, false)))
        }
    }
}

func nextState(_ swiftState: QuickReturnSwiftState) -> FooterAnimation {
    let current = swiftState.0
    let val = swiftState.1
    if swiftState.2 {
        return current == .default ? .invalid : current.nextState()
    } else {
        return current == .done ? .invalid : (val < thresHold ? .done : .moving)
    }
}

extension ViewController {
    var footerAnimationState: FooterAnimation {
        get {
            return getProperty("footerAnimationState", initial: .Default)
        }
        set {
            setValue(newValue, forProperty: "footerAnimationState")
        }
    }
    var containerHeight: Float {
        get { return Float(recognizeEmployeeContainerHeight.constant) }
        set {}
    }
    @IBOutlet weak var recognizeEmployeeContainerHeight: NSLayoutConstraint! {
        get {
            return getProperty("recognizeEmployeeContainerHeight", initial: NSLayoutConstraint.init())
        }
        set {
            setValue(newValue, forProperty: "recognizeEmployeeContainerHeight")
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        get {
            return getProperty("tableView", initial: UITableView.init())
        }
        set {
            setValue(newValue, forProperty: "tableView")
        }
    }
    @IBOutlet weak var buttonView: UIView! {
        get {
            return getProperty("buttonView", initial: UIView.init())
        }
        set {
            setValue(newValue, forProperty: "buttonView")
        }
    }
    ///////////////////////////FUNCTIONS/////////////////////////////////////
    internal func setInitialRecognizeButtonHeight() {
        initialRecognizeButtonHeigth = CGFloat(containerHeight)
    }
    
    func percentQuickReturn(_ value: Float) -> Float {
        return abs(value / (Float(tableView.rowHeight) * 2 ))
    }
    
    func checkIfFullyAnimated() {
        if footerAnimationState == .moving {
            footerAnimationState.next()
            animateButtonHeight(checkpoint)
        }
    }
    
    func processPercentageHeight(_ percentage: Float) -> (Float) -> Float {
        return { height in
            return height * (1 - percentage)
        }
    }
    
    func getSetValue(_ initial: Float) -> (Float) -> Float {
        return { height in
            let percentage = self.percentQuickReturn(initial)
            return self.processPercentageHeight(percentage)(height)
        }
    }
    
    func animateButtonHeight(_ value: CGPoint) {
        let yValue = Float(value.y)
        let heightConstant = Float(recognizeEmployeeContainerHeight.constant)
        let scrollUp = yValue > 0
        let quickMove = quickReturn((scrollUp, getSetValue(yValue)(heightConstant)))(footerAnimationState)
        let finalState = quickMove.1
        if finalState != .invalid {
            footerAnimationState = quickMove.1
            let value = quickMove.0
            UIView.animate(withDuration: 0.5, animations: {
                let setValue = CGFloat(value)
                self.recognizeEmployeeContainerHeight.constant = setValue
                if scrollUp {
                    self.tableView.layoutIfNeeded()
                }
                self.buttonView.layoutIfNeeded()
            })
        }
    }
}
