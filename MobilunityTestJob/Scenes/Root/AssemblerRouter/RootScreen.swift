//
//  RootScreen.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

protocol RootRouter {
    func setRepositoriesListAsRootScreen()
}

protocol RootScreenInput {
    init(rootPresenter: RootViewOutput, rootVCFactory: () -> ((_ presenter: RootViewOutput) -> RootViewInput))
    func set(repositoriesListScreenFactory: () -> (() -> RepositoriesListScreen))
}

final class RootScreen {
    private let rootPresenter: RootViewOutput
    private weak var rootViewController: RootViewInput?
    private var rootViewControllerFactory: (_ presenter: RootViewOutput) -> RootViewInput
    /// TODO: Write comment here
    private var repositoriesListScreenFactory: (() -> RepositoriesListScreen)?
    
    init(rootPresenter: RootViewOutput, rootVCFactory: () -> ((_ presenter: RootViewOutput) -> RootViewInput)) {
        self.rootPresenter = rootPresenter
        self.rootViewControllerFactory = rootVCFactory()
    }
}

extension RootScreen: RootScreenInput {
    func set(repositoriesListScreenFactory: () -> (() -> RepositoriesListScreen)) {
        self.repositoriesListScreenFactory = repositoriesListScreenFactory()
    }
}

extension RootScreen: RootRouter {
    func setRepositoriesListAsRootScreen() {
        guard let repositoriesListVC = repositoriesListScreenFactory?() else {
            fatalError("repositoriesListVCFactory is nil")
        }
        let newChildVC = UINavigationController(rootViewController: repositoriesListVC.toPresentable())
        rootViewController?.update(childVC: newChildVC)
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
