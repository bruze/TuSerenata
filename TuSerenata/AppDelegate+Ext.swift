//
//  AppDelegate+Ext.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/19/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//
import DualSlideMenu

extension AppDelegate {
    func mostrarPantallaAterrizaje() {
        let storyboard = appDelegate.storyboard!
        let leftView = (storyboard.instantiateViewController(withIdentifier: "Menu") as? MenuVC)!
        let mainView = storyboard.instantiateInitialViewController()

        slide = DualSlideMenuViewController(mainViewController: mainView!, leftMenuViewController: leftView)
        slide?.delegate = leftView
        window?.rootViewController = slide
    }
    func logout() {
        try! Auth.auth().signOut()
        self.authorize()
    }
}
