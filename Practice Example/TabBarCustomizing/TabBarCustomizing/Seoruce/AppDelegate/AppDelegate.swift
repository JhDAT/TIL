//
//  AppDelegate.swift
//  TabBarCustomizing
//
//  Created by Jo JANGHUI on 2018. 9. 18..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let tbC = self.window?.rootViewController as? UITabBarController {
            if let tbItems = tbC.tabBar.items {
                tbItems[0].image = UIImage(named: "calendar")?.withRenderingMode(.alwaysOriginal)
                tbItems[1].image = UIImage(named: "folder")?.withRenderingMode(.alwaysOriginal)
                tbItems[2].image = UIImage(named: "picture")?.withRenderingMode(.alwaysOriginal)
                
                // 1) 전체를 순환 하면서 하는 방법
//                for tbItem in tbItems {
//                    let image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
//                    tbItem.selectedImage = image
//
//                    let colorRawValue = NSAttributedString.Key.foregroundColor.rawValue
//                    let fontRawValue = NSAttributedString.Key.font.rawValue
//
//                    tbItem.setTitleTextAttributes(
//                        [NSAttributedString.Key(rawValue: colorRawValue) : UIColor.gray],
//                        for: .disabled)
//                    tbItem.setTitleTextAttributes(
//                        [NSAttributedString.Key(rawValue: colorRawValue) : UIColor.red],
//                        for: .selected)
//                    tbItem.setTitleTextAttributes(
//                        [NSAttributedString.Key(rawValue: fontRawValue) : UIFont.systemFont(ofSize: 15)],
//                        for: .normal)
//                }
                
                // 2) 외형 프록시 객체를 사용해서 하는 방법
                for tbItem in tbItems {
                    let image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
                    tbItem.selectedImage = image
                }
                
                let tbItemProxy = UITabBarItem.appearance() // 탭 바 아이템의 외형 프록시 객체
                let colorRawValue = NSAttributedString.Key.foregroundColor.rawValue
                let fontRawValue = NSAttributedString.Key.font.rawValue
                
                tbItemProxy.setTitleTextAttributes(
                    [NSAttributedString.Key(rawValue: colorRawValue) : UIColor.gray],
                    for: .disabled)
                tbItemProxy.setTitleTextAttributes(
                    [NSAttributedString.Key(rawValue: colorRawValue) : UIColor.red],
                    for: .selected)
                tbItemProxy.setTitleTextAttributes(
                    [NSAttributedString.Key(rawValue: fontRawValue) : UIFont.systemFont(ofSize: 15)],
                    for: .normal)
                
                tbItems[0].title = "calendar"
                tbItems[1].title = "folder"
                tbItems[2].title = "picture"
            }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

