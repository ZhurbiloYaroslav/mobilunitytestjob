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
    func didLoad()
}

final class RootPresenter {
    private weak var view: RootViewInput?
}

extension RootPresenter: RootViewOutput {
    func attach(view: RootViewInput) {
        self.view = view
    }
    
    func didLoad() {
        // TODO: Implement it
    }
}
