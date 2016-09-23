//
//  ViewController+TableViewDataSource.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/22/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell.init(style: .Default, reuseIdentifier: "")
    }
}
