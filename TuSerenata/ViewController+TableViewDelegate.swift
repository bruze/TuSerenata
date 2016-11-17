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
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.contentInset = UIEdgeInsets.zero
        tableView.layer.borderColor = Global.CLRLoginTFieldBorder.cgColor
        tableView.layer.borderWidth = 1.0
        tableView.tableFooterView = UIView.init(frame: CGRect.init())
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView)
        if translation.y < 0 {
            guard abs(translation.y) > 10 else {
                return
            }
        }
        animateButtonHeight(translation)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        checkIfFullyAnimated()
    }
}
