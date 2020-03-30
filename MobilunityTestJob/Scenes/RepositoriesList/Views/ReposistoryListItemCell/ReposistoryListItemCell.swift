//
//  ReposistoryListItemCell.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class ReposistoryListItemCell: UICollectionViewCell {

    @IBOutlet weak var repositoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        repositoryName.text = ""
    }

    func configure(with model: RepositoriesListViewModelProtocol) {
        repositoryName.text = model.repositoryName
    }

}
