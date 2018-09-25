//
//  ControlVC.swift
//  AlertCuston
//
//  Created by Jo JANGHUI on 25/09/2018.
//  Copyright © 2018 JhDAT. All rights reserved.
//

import UIKit

class ControlVC: UIViewController {
    private let slider = UISlider()
    
    var sliderValue: Float {
        return self.slider.value
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.slider.minimumValue = 0
        self.slider.maximumValue = 100
        
        self.slider.frame = CGRect(x: 0, y: 0, width: 170, height: 30)
        self.view.addSubview(self.slider)
        
        //외부 객체가 해당 뷰 컨트롤러를 타나낼 때 참고할 사이즈
        self.preferredContentSize = CGSize(width: self.slider.frame.width, height: self.slider.frame.height + 10)

    }
}
