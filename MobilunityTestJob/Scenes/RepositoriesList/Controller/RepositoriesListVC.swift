//
//  RepositoriesListVC.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import IGListKit

protocol RepositoriesListViewInput: class, Presentable {
    var isRefreshing: Bool { get }
    func attach(output: RepositoriesListViewOutput)
    func update(sections: [RepositoriesListSection])
}

class RepositoriesListVC: UIViewController {
    
    @IBOutlet private var collectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    private var output: RepositoriesListViewOutput?

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 3)
    }()
    private var sections: [ListDiffable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTitle()
        configureAdapter()
        configureRefreshControl()
        output?.didLoad()
    }
    
    private func updateTitle() {
        navigationItem.title = "Square repositories"
    }
    
    private func configureAdapter() {
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    private func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(handleRefreshControlDidChange), for: .valueChanged)
        refreshControl.tintColor = .darkGray
        collectionView.refreshControl = refreshControl
    }
    
    @objc func handleRefreshControlDidChange() {
        output?.reloadData()
    }

}

extension RepositoriesListVC: RepositoriesListViewInput {
    
    var isRefreshing: Bool { refreshControl.isRefreshing }
    
    func attach(output: RepositoriesListViewOutput) {
        self.output = output
    }
    
    func update(sections: [RepositoriesListSection]) {
        self.sections = sections
        refreshControl.endRefreshing()
        adapter.performUpdates(animated: true, completion: nil)
    }
}

extension RepositoriesListVC: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        sections
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if let section = object as? RepositoriesListSection {
            switch section.id {
            case .empty:
                return PlaceholderSectionController(height: collectionView.bounds.height,
                                                    viewModel: PlaceholderCellEmptyViewModel(buttonModel: PlaceholderCellEmptyButtonModel(buttonAction: { [weak self] in
                                                        self?.output?.reloadData()
                                                    })))
            case .error(let title, let message):
                let viewModel = PlaceholderCellErrorViewModel(title: title, message: message, buttonModel: PlaceholderCellEmptyButtonModel(buttonAction: { [weak self] in
                    self?.output?.reloadData()
                }))
                return PlaceholderSectionController(height: collectionView.bounds.height, viewModel: viewModel)
            case .preload:
                return LoadingSectionController(height: collectionView.bounds.height)
            case .repository(let repository):
                return RepositoriesListItemSectionController(repository: repository,
                                                             edges: .init(top: 5, left: 0, bottom: 0, right: 0))
            }
        }
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
