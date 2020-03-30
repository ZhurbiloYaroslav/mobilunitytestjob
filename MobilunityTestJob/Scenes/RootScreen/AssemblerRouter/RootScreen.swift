//
//  RootScreen.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

final class RootScreen {
    private let rootPresenter: RootViewOutput
    private weak var rootViewController: RootViewInput?
    private var rootViewControllerFactory: (_ presenter: RootViewOutput) -> RootViewInput
    
    init(rootPresenter: RootViewOutput, rootVCFactory: () -> ((_ presenter: RootViewOutput) -> RootViewInput)) {
        self.rootPresenter = rootPresenter
        self.rootViewControllerFactory = rootVCFactory()
    }
}

extension RootScreen: UIWindowConfigurable {
    func configure(in window: UIWindow) {
        window.rootViewController = {
            let rootVC = rootViewControllerFactory(rootPresenter)
            rootViewController = rootVC
            return rootVC.toPresentable()
        }()
        window.makeKeyAndVisible()
    }
}
