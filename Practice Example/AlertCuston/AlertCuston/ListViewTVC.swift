//
//  ListViewTVC.swift
//  AlertCuston
//
//  Created by Jo JANGHUI on 25/09/2018.
//  Copyright © 2018 JhDAT. All rights reserved.
//

import UIKit

class ListViewTVC: UITableViewController {
    var delegate: MapAlertVC?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize.height = 220
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = "\(indexPath.row) 번째 옵션입니다."
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectRowAt(indexPath: indexPath)
    }
}
