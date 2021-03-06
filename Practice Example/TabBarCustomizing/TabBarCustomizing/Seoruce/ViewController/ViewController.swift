//
//  ViewController.swift
//  TabBarCustomizing
//
//  Created by Jo JANGHUI on 2018. 9. 18..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let title = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
        title.text = "첫번째 탭"
        title.textColor = .black
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 14)
        
        title.sizeToFit()       // 콘텐츠에 맞게 레이블 크기 변경
        
        title.center.x = self.view.frame.width / 2
        self.view.addSubview(title)
    }
    
    // 첫번째 탭에의 화면을 누르면 탭바 숨기기 동작
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tabBar = self.tabBarController?.tabBar
//        tabBar?.isHidden = (tabBar?.isHidden == true) ? false : true
        
        UIView.animate(withDuration: 0.15) {
            tabBar?.alpha = tabBar?.alpha == 0 ? 1 : 0
        }
    }
}

