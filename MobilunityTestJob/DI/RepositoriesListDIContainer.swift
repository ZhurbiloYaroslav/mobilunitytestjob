//
//  RepositoriesListDIContainer.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import Swinject

typealias RepositoriesListVCFactory = (_ presenter: RepositoriesListViewOutput) -> RepositoriesListViewInput

class RepositoriesListDIContainer {
    private let container: Container
    
    init(parentContainer: Container) {
        container = Container(parent: parentContainer) { container in
            container.register(RepositoriesListScreen.self) { resolver in
                let presenter = resolver.resolve(RepositoriesListViewOutput.self)!
                return RepositoriesListScreen(repositoriesListPresenter: presenter) {
                    container.resolve(RepositoriesListVCFactory.self, argument: presenter)!
                }
            }
            container.register(RepositoriesListViewOutput.self) { resolver in
                let networkManager = resolver.resolve(NetworkManagerProtocol.self)!
                return RepositoriesListPresenter(networkManager: networkManager)
            }
            container.register(RepositoriesListViewInput.self) { resolver in
                R.storyboard.repositoriesList.repositoriesListVC()!
            }
            container.register(RepositoriesListVCFactory.self) {
                (resolver, presenter: RepositoriesListViewOutput) -> RepositoriesListVCFactory in
                return { presenter in
                    let viewController = resolver.resolve(RepositoriesListViewInput.self)!
                    viewController.attach(output: presenter)
                    presenter.attach(view: viewController)
                    return viewController
                }
            }
        }
    }
    
    public func makeRepositoriesScreen() -> RepositoriesListScreen {
        container.resolve(RepositoriesListScreen.self)!
    }
}
