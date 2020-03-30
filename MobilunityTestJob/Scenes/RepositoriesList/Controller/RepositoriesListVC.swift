//
//  RepositoriesListVC.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import IGListKit

protocol RepositoriesListViewInput: class, Presentable {
    func attach(output: RepositoriesListViewOutput)
    func update(sections: [RepositoriesListSection])
}

class RepositoriesListVC: UIViewController {
    
    @IBOutlet private var collectionView: UICollectionView!
    private var output: RepositoriesListViewOutput?

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    private var sections: [ListDiffable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAdapter()
        output?.didLoad()
    }
    
    func configureAdapter() {
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

}

extension RepositoriesListVC: RepositoriesListViewInput {
    func attach(output: RepositoriesListViewOutput) {
        self.output = output
    }
    
    func update(sections: [RepositoriesListSection]) {
        self.sections = sections
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
                // TODO: Implement it
                return ListSectionController()
            case .preload:
                // TODO: Implement it
                return ListSectionController()
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
