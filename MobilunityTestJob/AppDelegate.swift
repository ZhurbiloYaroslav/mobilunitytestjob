//
//  AppDelegate.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let appDependencyContainer = AppDependencyContainer()
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureRootScreenInWindow()
        return true
    }
    
    func configureRootScreenInWindow() {
        let newWindow = UIWindow(frame: UIScreen.main.bounds)
        window = newWindow
    }
}

