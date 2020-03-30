//
//  RepositoriesListViewModel.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

protocol RepositoriesListViewModelProtocol {
    var repositoryId: Int { get }
    var repositoryName: String { get }
    var repositoryDetails: String { get }
}

struct RepositoriesListViewModel: RepositoriesListViewModelProtocol {
    let repositoryId: Int
    let repositoryName: String
    let repositoryDetails: String
    
    init(repositoryModel: SquareRepositoryModelProtocol) {
        repositoryId = repositoryModel.id
        repositoryName = repositoryModel.name
        repositoryDetails = repositoryModel.description ?? ""
    }
}
