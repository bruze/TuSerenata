//
//  Global.swift
//  e2e
//
//  Created by Bruno Garelli on 4/13/16.
//  Copyright © 2016 Altimetrik. All rights reserved.
//

import Foundation
import UIKit
import UCZProgressView

typealias GlobS = Global.Strings
typealias GlobB = Global.Buttons
typealias Filter = Global.Filter
typealias Notif = Global.Notifications
typealias GlobErr = Global.ErrorMessages

typealias DicStrAny = [String: AnyObject]
typealias DicStrStr = [String: String]
typealias BloqueVoid = () -> ()
typealias BloqueBoton = (AMKButton) -> ()
typealias ChequeoGrupo = (Musico) -> Bool

let gerente = Gerente.unistancia
let usuario = gerente.usuario
let notifiCenter = NSNotificationCenter.defaultCenter()
let cargaVacia = UCZProgressView.init()
let bundle = NSBundle.init()
let fileMan = NSFileManager.defaultManager()

infix operator ~> {}
private let queue = dispatch_queue_create("serial-worker", DISPATCH_QUEUE_SERIAL)
//MARK: Global Operators
func ~> <R> (
    backgroundClosure: () -> R,
    mainClosure:       (result: R) -> ()) {

    dispatch_async(queue) {
        let result = backgroundClosure()
        dispatch_async(dispatch_get_main_queue(), {
            mainClosure(result: result)
        })
    }
}
let emptyLayer = CALayer.init()
public struct Global {
    enum RLMove {
        case Right
        case Left
    }
    static public func stringToInt(value: String) -> Int? {
        if let num = NSNumberFormatter().numberFromString(value) {
            return num.integerValue
        } else {
            return nil
        }
    }
    static let CLRWhite = Global.initColor(255, green: 255, blue: 255)

    static let CLRAppBack = Global.initColor(63, green: 172, blue: 199)
    static let CLRAllSelect = Global.initColor(3, green: 172, blue: 199)
    static let CLRGivenSelect = Global.initColor(63, green: 199, blue: 66)
    static let CLRReceivedSelect = Global.initColor(245, green: 166, blue: 35)
    static let CLRLikeGray = Global.initColor(210, green: 210, blue: 210)

    static let CLRRecognizeEmployeeDescription = Global.initColor(114, green: 144, blue: 144)
    static let CLRRecognizeEmployeeDef = Global.initColor(63, green: 182, blue: 199)
    static let CLRRecognizeEmployeePress = Global.initColor(31, green: 122, blue: 153)
    static let CLRRecognizeValue = Global.initColor(114, green: 114, blue: 114)

    static let CLRDepartmentButton = Global.initColor(240, green: 240, blue: 240)
    static let CLRMenuButtonPress = Global.initColor(240, green: 240, blue: 240)
    static let CLRMenuButton = Global.initColor(255, green: 255, blue: 255)

    static let CLRLoginDefault = Global.initColor(63, green: 172, blue: 199)
    static let CLRLoginPressed = Global.initColor(42, green: 168, blue: 205)
    static let CLRLoginTFieldBorder = Global.initColor(210, green: 210, blue: 210)
    static let CLRLoginTFieldShadow = Global.initColor(0, green: 0, blue: 0, alpha: 0.26)

    static let CLRLoginBackShadow = Global.initColor(0, green: 0, blue: 0, alpha: 0.60)

    enum Filter: UInt {
        case All = 0
        case Given
        case Received

        func toString() -> String {
            switch self {
            case .All:
                return "all"
            case .Given:
                return "given"
            case .Received:
                return "received"
            }
        }
    }

    enum Buttons: String {
        case LikeAll="buttonLikeAll"
        case LikeGiven="buttonLikeGiven"
        case LikeReceived="buttonLikeReceived"

        func empty() -> String {
            return self.rawValue+"Empty"
        }

        func raw() -> String {
            return self.rawValue
        }
    }

    enum Notifications: String {

        case ShowAAlert = "ShowAAlert"

        case ShowAToast = "ShowAToast"

        func raw() -> String {
            return self.rawValue
        }
    }

    //MARK: Global Functions

    static func initColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1)
                                                                                -> UIColor {
        let color = UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
        return color
    }

    static func distinct<T: Equatable>(source: [T]) -> [T] {
        var unique = [T]()
        for item in source {
            if !unique.contains(item) {
                unique.append(item)
            }
        }
        return unique
    }

    static func stylizeTextFieldDefault(textField: UITextField!) {
        textField.layer.borderColor = Global.CLRLoginTFieldBorder.CGColor
        textField.layer.borderWidth = 1.0
        textField.backgroundColor = UIColor.whiteColor()
        textField.layer.shadowOpacity = 0.0
        textField.background = UIImage()
    }

    static func stylizeTextFieldOnFocus(textField: UITextField!) {
        textField.layer.shadowColor = Global.CLRLoginTFieldShadow.CGColor
        textField.layer.masksToBounds = false
        textField.layer.shadowOpacity = 1.0

        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        var blurFrame = textField.bounds
        blurFrame.size.height += 2.0
        blurEffectView.frame = blurFrame
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]

        //Set the blurred image made from blurred view as textfield's background
        textField.background = imageWithView(blurEffectView)
    }

    static func stylizeTextViewDefault(textView: UITextView!) {
        textView.textContainerInset  = UIEdgeInsets(top: 12, left: 8, bottom: 0, right: 0)
        textView.layer.borderColor   = Global.CLRLoginTFieldBorder.CGColor
        textView.layer.borderWidth   = 1.0
        textView.layer.shadowOpacity = 0.0
        textView.backgroundColor     = UIColor.whiteColor()
    }

    static func stylizeTextViewOnFocus(textView: UITextView!) {
        textView.layer.shadowColor = Global.CLRLoginTFieldShadow.CGColor
        textView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        textView.layer.masksToBounds = false
        textView.layer.shadowRadius = 3.0
        textView.layer.shadowOpacity = 1.0

        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        var blurFrame = textView.bounds
        blurFrame.size.height += 2.0
        blurEffectView.frame = blurFrame
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        blurEffectView.backgroundColor = UIColor.whiteColor()

        //Set the blurred image made from blurred view as textfield's background
        textView.backgroundColor = UIColor(patternImage: imageWithView(blurEffectView))
    }

    static func imageWithView(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    static func iterateEnum<T: Hashable>(_: T.Type) -> AnyGenerator<T> {
        var i = 0
        return AnyGenerator {
            let next = withUnsafePointer(&i) { UnsafePointer<T>($0).memory }
            //let increment = i+1
            defer {
                i += 1
            }
            return next.hashValue == i ? next : nil
        }
    }

    //MARK: Error Messages
    //static let ErrorNetwork = NSLocalizedString("NetworkError", comment: "")
    enum ErrorMessages: String {

        case Network                = "NetworkError"
        case OAuthExpires           = "OAuthExpiresError"
        case FetchEmployee          = "FetchEmployeeError"
        case FetchDepartments       = "FetchDepartmentsError"
        case UnableToLogin          = "UnableToLoginError"
        case FetchRecognitions      = "FetchRecognitionsError"
        case FetchRecognitionValues = "FetchRecognitionValuesError"
        case QRDecode               = "QRDecodeError"
        case GetEmployeeByName      = "GetEmployeeByNameError"
        case Credentials            = "CredentialsError"
        case FetchLoggedUser        = "FetchLoggedUserError"
        case CreateRecognition      = "CreateRecognitionError"
        case FetchRedeemItems       = "FetchRedeemItemsError"
        case FetchRedemptions       = "FetchRedemptionsError"
        case CreateRedemptionError  = "CreateRedemptionError"
        case UnknownError           = "UnknownError"
        case FetchFAQ               = "FetchFAQ"

        func raw() -> String {
            return NSLocalizedString(self.rawValue, comment: "")
        }
    }

    enum Strings: String {
        case All = "All"
        case Given = "Given"

        case EnterDescription = "enter_description"

        //FONTS
        case SFUIDispBlack="SFUIDisplay-Black"
        case SFUIDispBold="SFUIDisplay-Bold"
        case SFUIDispHeavy="SFUIDisplay-Heavy"
        case SFUIDispLight="SFUIDisplay-Light"
        case SFUIDispMedium="SFUIDisplay-Medium"
        case SFUIDispRegular="SFUIDisplay-Regular"
        case SFUIDispSemibold="SFUIDisplay-Semibold"
        case SFUIDispThin="SFUIDisplay-Thin"
        case SFUIDispUltralight="SFUIDisplay-Ultralight"

        case SFUITextBold="SFUIText-Bold"
        case SFUITextBoldItalic="SFUIText-BoldItalic"
        case SFUITextHeavy="SFUIText-Heavy"
        case SFUITextHeavyItalic="SFUIText-HeavyItalic"
        case SFUITextLight="SFUIText-Light"
        case SFUITextLightItalic="SFUIText-LightItalic"
        case SFUITextMedium="SFUIText-Medium"
        case SFUITextMediumItalic="SFUIText-MediumItalic"
        case SFUITextRegular="SFUIText-Regular"
        case SFUITextRegularItalic="SFUIText-RegularItalic"
        case SFUITextSemibold="SFUIText-Semibold"
        case SFUITextSemiboldItalic="SFUIText-SemiboldItalic"

        func raw() -> String {
            let localized = NSLocalizedString(self.rawValue, comment: "")
            if localized.isNotEmpty() {
                return localized
            }
            return self.rawValue
        }
    }

    static func kFormatter(num: Int) -> String {
        if num > 999 {
            let formatter = NSNumberFormatter()
            formatter.minimumFractionDigits = 1
            formatter.maximumFractionDigits = 1
            formatter.roundingMode = .RoundDown
            return formatter.stringFromNumber(Double(num)/1000)! + "K"
        }
        return "\(num)"

    }

    static func notifyStopRefreshing() {
        let notiCenter = NSNotificationCenter.defaultCenter()
        notiCenter.postNotification(
                    NSNotification(name: "stopRefreshing", object: nil)
        )
    }

    static func toastMessage(message: String) {
        let notiCenter = NSNotificationCenter.defaultCenter()
        notiCenter.postNotificationName(Notif.ShowAToast.raw(),
                                        object:nil,
                                        userInfo:["message": message])
    }
    static func alertMessage(message: String) {
        let notiCenter = NSNotificationCenter.defaultCenter()
        notiCenter.postNotificationName(Notif.ShowAAlert.raw(),
                                        object:nil,
                                        userInfo:["message": message])
    }

}

extension UIColor {
    class func e2eGreyishBrownColor() -> UIColor {
        return UIColor(white: 85.0 / 255.0, alpha: 1.0)
    }

    class func e2eGreenBlueColor() -> UIColor {
        return UIColor(red: 0.0 / 255.0, green: 189.0 / 255.0, blue: 156.0 / 255.0, alpha: 1.0)
    }

    class func e2eWindowsBlueColor() -> UIColor {
        return UIColor(red: 63.0 / 255.0, green: 172.0 / 255.0, blue: 199.0 / 255.0, alpha: 1.0)
    }

    class func e2eMidBlueColor() -> UIColor {
        return UIColor(red: 31.0 / 255.0, green: 122.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0)
    }

    class func e2eTurquoiseBlueColor() -> UIColor {
        return UIColor(red: 3.0 / 255.0, green: 172.0 / 255.0, blue: 199.0 / 255.0, alpha: 1.0)
    }

    class func e2ePaleOrangeColor() -> UIColor {
        return UIColor(red: 255.0 / 255.0, green: 166.0 / 255.0, blue: 77.0 / 255.0, alpha: 1.0)
    }

    class func e2eTomatoColor() -> UIColor {
        return UIColor(red: 233.0 / 255.0, green: 76.0 / 255.0, blue: 54.0 / 255.0, alpha: 1.0)
    }

    class func e2eWarmGreyColor() -> UIColor {
        return UIColor(red: 114.0 / 255.0, green: 114.0 / 255.0, blue: 114.0 / 255.0, alpha: 1.0)
    }

    class func e2eWarmGrey2Color() -> UIColor {
        return UIColor(red: 137.0 / 255.0, green: 137.0 / 255.0, blue: 137.0 / 255.0, alpha: 1.0)
    }

    class func e2eBlackColor() -> UIColor {
        return UIColor(red: 1.0 / 255.0, green: 1.0 / 255.0, blue: 1.0 / 255.0, alpha: 1.0)
    }

    class func e2eBlack26Color() -> UIColor {
        return UIColor(white: 0.0, alpha: 0.26)
    }

    class func e2eBlack30Color() -> UIColor {
        return UIColor(white: 0.0, alpha: 0.30)
    }
}
