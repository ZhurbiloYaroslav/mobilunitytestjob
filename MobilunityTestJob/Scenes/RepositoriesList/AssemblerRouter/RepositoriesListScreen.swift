//
//  RepositoriesListScreen.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

protocol RepositoriesListRouter {
    func openDetails(of model: SquareRepositoryModel)
}

class RepositoriesListScreen: Presentable {
    private let repositoriesListPresenter: RepositoriesListViewOutput
    private let repositoriesListVCFactory: RepositoriesListVCFactory
    
    init(repositoriesListPresenter: RepositoriesListViewOutput,
         repositoriesListVCFactory: () -> (RepositoriesListVCFactory)) {
        self.repositoriesListPresenter = repositoriesListPresenter
        self.repositoriesListVCFactory = repositoriesListVCFactory()
    }
    
    func toPresentable() -> UIViewController {
        repositoriesListVCFactory(repositoriesListPresenter).toPresentable()
    }
}

extension RepositoriesListScreen: RepositoriesListRouter {
    func openDetails(of model: SquareRepositoryModel) {
        // Intentionally left blank
    }
}
