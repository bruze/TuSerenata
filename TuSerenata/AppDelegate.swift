//
//  AppDelegate.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/15/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//
import UIKit
import DualSlideMenu
import IQKeyboardManagerSwift
import Firebase
import JLChatViewController
import CoreLocation

let appDelegate = (UIApplication.sharedApplication().delegate as? AppDelegate)!
let FirebaseUrl = "https://tuserenata-dd913.firebaseio.com/"
let FirebaseRef = FIRDatabase.database().reference()
let localizador = CLLocationManager.init()
//let FirebaseRef = Firebase(url: FirebaseUrl)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard: UIStoryboard?
    var slide: DualSlideMenuViewController?
    
    override init() {
        super.init()
        localizador.requestAlwaysAuthorization()
        FIRApp.configure()
        FIRDatabase.database().persistenceEnabled = true
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        //try! FIRAuth.auth()?.signOut()
        if let authorized = FIRAuth.auth()?.currentUser {
            mostrarPantallaAterrizaje()
            Gerente.unistancia.obtenerUsuario(authorized.uid, finalizar: {usuario in
                Gerente.unistancia.usuario = usuario
            })
        } else {
            print("Please log in")
            let login = storyboard!.instantiateViewControllerWithIdentifier("Login")
            window!.rootViewController = login//slide
            window!.makeKeyAndVisible()
        }
        
        JLChatAppearence.configIncomingMessages(nil, showIncomingSenderImage: false, incomingTextColor: nil)
        JLChatAppearence.configOutgoingMessages(nil, showOutgoingSenderImage: false, outgoingTextColor: nil)
        
        JLBundleController.loadJLChatStoryboard()
        IQKeyboardManager.sharedManager().enable = true
        PayPalMobile.initializeWithClientIdsForEnvironments([PayPalEnvironmentSandbox: "bruno.garelli-facilitator_api1.yahoo.com"])
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

