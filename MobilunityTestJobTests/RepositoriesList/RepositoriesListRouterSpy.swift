//
//  RepositoriesListRouterSpy.swift
//  MobilunityTestJobTests
//
//  Created by Yaroslav Zhurbilo on 31.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import XCTest
@testable import MobilunityTestJob

class RepositoriesListRouterSpy: RepositoriesListRouter {
    var onOpenDetailsOfModel: ((_ model: SquareRepositoryModel) -> Void)?
    func openDetails(of model: SquareRepositoryModel) {
        onOpenDetailsOfModel?(model)
    }
}
