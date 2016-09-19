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
        let leftView = storyboard.instantiateViewControllerWithIdentifier("Menu")
        let mainView = storyboard.instantiateInitialViewController()

        slide = DualSlideMenuViewController(mainViewController: mainView!, leftMenuViewController: leftView)
        window?.rootViewController = slide
    }
}
