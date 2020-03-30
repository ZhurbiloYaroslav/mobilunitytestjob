//
//  RepositoriesListPresenter.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import RxSwift

protocol RepositoriesListViewOutput {
    func attach(view: RepositoriesListViewInput)
    func attach(router: RepositoriesListRouter)
    func didLoad()
}

class RepositoriesListPresenter {
    private weak var view: RepositoriesListViewInput?
    private var router: RepositoriesListRouter?
    private var networkManager: NetworkManagerProtocol
    private let disposeBag = DisposeBag()
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchData() {
        networkManager
            .request(GitHubAPI.SquareRepos.getRepositories())
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                self?.handleSuccess(response: response)
            }, onError: { error in
                // TODO: Handle it
            })
            .disposed(by: disposeBag)
    }
    
    func handleSuccess(response: [SquareRepositoryModel]) {
        let repositorySections: [RepositoriesListSection] = response.map {
            let viewModel = RepositoriesListViewModel(repositoryModel: $0)
            return RepositoriesListSection(id: .repository(viewModel))
        }
        view?.update(sections: repositorySections)
    }
    
}

extension RepositoriesListPresenter: RepositoriesListViewOutput {
    func didLoad() {
        fetchData()
    }
    
    func attach(view: RepositoriesListViewInput) {
        self.view = view
    }
    
    func attach(router: RepositoriesListRouter) {
        self.router = router
    }
}
