//
//  LoadingCell.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 31.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

final class LoadingCell: UICollectionViewCell {
    static let height: CGFloat = 50
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    func startActivityIndicatorAnimation() {
        activityIndicator.startAnimating()
    }
    
    func updateSpinner(color: UIColor) {
        activityIndicator.color = color
    }
}
