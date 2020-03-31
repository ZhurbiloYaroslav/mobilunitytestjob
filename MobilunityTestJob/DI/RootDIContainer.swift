//
//  RootDIContainer.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import Swinject

typealias RootVCFactory = (_ presenter: RootViewOutput) -> RootViewInput
typealias RepositoriesListScreenFactory = () -> RepositoriesListScreen

class RootDIContainer {
    private let container: Container
    
    init(parentContainer: Container) {
        container = Container(parent: parentContainer) { container in
            container.register(RootScreen.self) { resolver -> RootScreen in
                let presenter = resolver.resolve(RootViewOutput.self)!
                let rootScreen = RootScreen(rootPresenter: presenter, rootVCFactory: {
                    resolver.resolve(RootVCFactory.self, argument: presenter)!
                })
                rootScreen.set(repositoriesListScreenFactory: {
                    resolver.resolve(RepositoriesListScreenFactory.self)!
                })
                presenter.attach(router: rootScreen)
                return rootScreen
            }
            container.register(RootViewOutput.self) { resolver -> RootViewOutput in
                RootPresenter()
            }
            container.register(RootVCFactory.self) { (resolver, presenter: RootViewOutput) -> RootVCFactory in
                return { presenter in
                    let viewController = RootViewController()
                    viewController.attach(output: presenter)
                    presenter.attach(view: viewController)
                    return viewController
                }
            }
            container.register(RepositoriesListScreenFactory.self) { _ in
                return {
                    RepositoriesListDIContainer(parentContainer: container).makeRepositoriesScreen()
                }
            }
        }
    }
    
    func makeRootScreen() -> RootScreen {
        container.resolve(RootScreen.self)!
    }
}
