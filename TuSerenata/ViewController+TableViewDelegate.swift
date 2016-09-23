//
//  ViewController+TableViewDelegate.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/22/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDelegate {
    func setupTable() {
        tableView.layoutMargins = UIEdgeInsetsZero
        tableView.contentInset = UIEdgeInsetsZero
        tableView.layer.borderColor = Global.CLRLoginTFieldBorder.CGColor
        tableView.layer.borderWidth = 1.0
        tableView.tableFooterView = UIView.init(frame: CGRect.init())
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.separatorStyle = .None
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.selected = false
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let translation = scrollView.panGestureRecognizer.translationInView(scrollView)
        if translation.y < 0 {
            guard abs(translation.y) > 10 else {
                return
            }
        }
        animateButtonHeight(translation)
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        checkIfFullyAnimated()
    }
}
