//
//  RootPresenter.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

protocol RootViewOutput {
    func attach(view: RootViewInput)
    func attach(router: RootRouter)
    func didLoad()
}

final class RootPresenter {
    private weak var view: RootViewInput?
    private var router: RootRouter?
}

extension RootPresenter: RootViewOutput {
    func attach(view: RootViewInput) {
        self.view = view
    }
    
    func attach(router: RootRouter) {
        self.router = router
    }
    
    func didLoad() {
        router?.setRepositoriesListAsRootScreen()
    }
}
