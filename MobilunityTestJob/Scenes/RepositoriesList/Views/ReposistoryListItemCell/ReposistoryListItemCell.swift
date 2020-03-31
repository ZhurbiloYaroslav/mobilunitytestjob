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
    @IBOutlet weak var repositoryDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        repositoryName.text = ""
        repositoryDetails.text = ""
    }

    func configure(with model: RepositoriesListViewModelProtocol) {
        repositoryName.text = model.repositoryName
        repositoryDetails.text = model.repositoryDetails
    }

}
