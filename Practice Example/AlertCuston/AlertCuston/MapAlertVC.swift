//
//  MapAlertVC.swift
//  AlertCuston
//
//  Created by Jo JANGHUI on 2018. 9. 24..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit
import MapKit

class MapAlertVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let alertBtn = UIButton(type: .system)
        
        alertBtn.frame = CGRect(x: 0, y: 150, width: 100, height: 30)
        alertBtn.center.x = self.view.frame.width / 2
        alertBtn.setTitle("Map Alert", for: .normal)
        alertBtn.addTarget(self, action: #selector(mapAlert), for: .touchUpInside)
        
        self.view.addSubview(alertBtn)
    }
    
    @objc func mapAlert(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "여기가 맞습니까?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        let contentVC = MapKitVC()
        
        
        
        alert.setValue(contentVC, forKey: "contentViewController")
        
        self.present(alert, animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
