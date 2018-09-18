//
//  NewAppDelegate.swift
//  TabBarCustomizing
//
//  Created by Jo JANGHUI on 2018. 9. 18..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

@UIApplicationMain

class NewAppDelegate: UIResponder, UIApplicationDelegate{
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let tbC = UITabBarController()
        tbC.view.backgroundColor = .white
        
        self.window?.rootViewController = tbC
        
        let view01 = ViewController()
        let view02 = SecondVC()
        let view03 = ThirdVC()
        
        tbC.setViewControllers([view01, view02, view03], animated: false)

        view01.tabBarItem = UITabBarItem(title: "calendar", image: UIImage(named: "calendar"), selectedImage: nil)
        view02.tabBarItem = UITabBarItem(title: "folder", image: UIImage(named: "folder"), selectedImage: nil)
        view03.tabBarItem = UITabBarItem(title: "picture", image: UIImage(named: "picture"), selectedImage: nil)
        
        return true
    }
    
}
