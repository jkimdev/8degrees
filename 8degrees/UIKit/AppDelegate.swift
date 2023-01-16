//
//  AppDelegate.swift
//  8degrees
//
//  Created by Jimmy on 2022/12/23.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Thread.sleep(forTimeInterval: 2.0)
        UINavigationBar.appearance().backIndicatorImage = UIImage(systemName: "arrow.left.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
//        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = UIColor(.clear)
        
        return true
    }
}
