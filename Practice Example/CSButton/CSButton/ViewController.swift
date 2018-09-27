//
//  ViewController.swift
//  CSButton
//
//  Created by Jo JANGHUI on 27/09/2018.
//  Copyright © 2018 JhDAT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let circleBtn = CSButton(type: .circle)
        circleBtn.frame = CGRect(x: 200, y: 200, width: 150, height: 30)
        self.view.addSubview(circleBtn)
        circleBtn.style = .rect
    }


}

