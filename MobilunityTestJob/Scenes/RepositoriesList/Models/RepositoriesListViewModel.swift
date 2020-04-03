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
    var repositoryImageUrl: URL? { get }
}

struct RepositoriesListViewModel: RepositoriesListViewModelProtocol {
    let repositoryId: Int
    let repositoryName: String
    let repositoryDetails: String
    let repositoryImageUrl: URL?
    
    init(repositoryModel: RepositoryModelling) {
        repositoryId = repositoryModel.id
        repositoryName = repositoryModel.name
        repositoryDetails = repositoryModel.description ?? ""
        repositoryImageUrl = repositoryModel.owner.avatarUrl
    }
}
