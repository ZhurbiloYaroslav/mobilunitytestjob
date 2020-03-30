//
//  RepositoriesListPresenter.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

protocol RepositoriesListViewOutput {
    func attach(view: RepositoriesListViewInput)
    func didLoad()
}

class RepositoriesListPresenter {
    private weak var view: RepositoriesListViewInput?
    
}

extension RepositoriesListPresenter: RepositoriesListViewOutput {
    func didLoad() {
        
    }
    
    func attach(view: RepositoriesListViewInput) {
        self.view = view
    }
}
