//
//  Login.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/16/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
import DualSlideMenu

class Login: UIViewController {
    internal func intenteLogueo() {
        FirebaseRef.authUser("prueba@gmail.com", password: "1234") { (error, auth) in
            if FirebaseRef.authData != nil {
                let meKnow = true
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // 1
        FirebaseRef.observeAuthEventWithBlock { (authData) -> Void in
            // 2
            if authData != nil {
                // 3
                let storyboard = appDelegate.storyboard!
                let leftView = storyboard.instantiateViewControllerWithIdentifier("Menu")
                 let mainView = storyboard.instantiateInitialViewController()
                 
                 let slide = DualSlideMenuViewController(mainViewController: mainView!, leftMenuViewController: leftView)
                appDelegate.window?.rootViewController = slide
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
