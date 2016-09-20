//
//  ViewController.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/15/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
import DualSlideMenu
import JLChatViewController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func itemMenuTap(sender: UIBarButtonItem) {
        print(Gerente.unistancia.usuario?.toAnyObject())
        appDelegate.slide!.toggle("right")
    }

    @IBAction func rightItemTap(sender: UIBarButtonItem) {
        if let vc = JLBundleController.instantiateJLChatVC() as? ChatVC {
            
            vc.view.frame = self.view.frame
            
            let chatSegue = UIStoryboardSegue(identifier: "goChat", source: self, destination: vc, performHandler: { () -> Void in
                
                self.navigationController?.pushViewController(vc, animated: true)
            })
            
            self.prepareForSegue(chatSegue, sender: nil)
            
            chatSegue.perform()
        }
    }
}

