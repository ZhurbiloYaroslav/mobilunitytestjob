//
//  RepositoriesListItemSectionController.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import IGListKit

final class RepositoriesListItemSectionController: ListSectionController {
    
    private let repository: RepositoriesListViewModelProtocol
    
    init(repository: RepositoriesListViewModelProtocol, edges: UIEdgeInsets) {
        self.repository = repository
        super.init()
        inset = edges
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let containerSize = collectionContext?.containerSize
            else { return .zero }
        let size: CGSize = {
            let width = containerSize.width - inset.left - inset.right
            let height = ReposistoryListItemCell.height(for: width,
                                                        title: repository.repositoryName,
                                                        subtitle: repository.repositoryDetails)
            return .init(width: width, height: height)
        }()
        return CGSize(width: size.width, height: size.height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?
            .dequeueReusableCell(withNibName: R.nib.reposistoryListItemCell.name,
                                 bundle: nil,
                                 for: self, at: index) as? ReposistoryListItemCell
            else { fatalError() }
        cell.configure(with: repository)
        return cell
    }
}
