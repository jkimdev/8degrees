//
//  AppDelegate.swift
//  8degrees
//
//  Created by Jimmy on 2022/12/23.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UINavigationBar.appearance().backIndicatorImage = UIImage(systemName: "arrow.left.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = .clear
        return true
    }
}
