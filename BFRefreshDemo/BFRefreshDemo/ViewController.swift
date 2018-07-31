//
//  ViewController.swift
//  BFRefreshDemo
//
//  Created by HJQ on 2018/7/29.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshBlock = { [weak self] in
            print(self ?? "")
        }

    }

    // MARK: - Event response
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        index = sender.selectedSegmentIndex
        if index == 0 {
            tableView.set(loadType: .normal)
        } else if index == 1 {
            tableView.set(loadType: .loading)
        } else if index == 2 {
            tableView.set(loadType: .noData)
        } else if index == 3 {
            tableView.set(loadType: .noNetwork)
        } else if index == 4 {
            tableView.set(loadType: .error)
        }
    }
    

}

