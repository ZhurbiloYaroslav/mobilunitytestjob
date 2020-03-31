//
//  ReposistoryListItemCell.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import BonMot

class ReposistoryListItemCell: UICollectionViewCell {
    typealias `Self` = ReposistoryListItemCell

    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var repositoryDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        repositoryName.attributedText = nil
        repositoryDetails.attributedText = nil
    }

    func configure(with model: RepositoriesListViewModelProtocol) {
        repositoryName.attributedText = model.repositoryName.styled(with: Self.titleStyle)
        repositoryDetails.numberOfLines = 3
        repositoryDetails.lineBreakMode = .byWordWrapping
        repositoryDetails.attributedText = model.repositoryDetails.styled(with: Self.subtitleStyle)
    }
    
    static func height(for width: CGFloat, title: String?, subtitle: String?) -> CGFloat {
        let availableWidth = width - edges.left - edges.right
        let size = CGSize(width: availableWidth, height: .greatestFiniteMagnitude)
        let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
        let titleHeight = (title ?? "").styled(with: titleStyle).boundingRect(with: size, options: options, context: nil).height
        let subtitleHeight = (subtitle ?? "").styled(with: subtitleStyle).boundingRect(with: size, options: options, context: nil).height
        return max(minHeight, edges.top + ceil(titleHeight + subtitleHeight) + edges.bottom)
    }

}

// MARK: - Cell styles
extension ReposistoryListItemCell {
    private static let minHeight: CGFloat = 20
    private static let edges: UIEdgeInsets = {
        let middleAndBottom: CGFloat = 8 + 8
        return UIEdgeInsets(top: 8, left: 16, bottom: middleAndBottom, right: 16)
    }()
    private static let titleStyle: StringStyle = {
        StringStyle(.font(UIFont.defaultFont(.regular, size: 16)),
                    .color(.white))
    }()
    private static let subtitleStyle: StringStyle = {
        StringStyle(.font(UIFont.defaultFont(.regular, size: 14)),
                    .color(.white))
    }()
}
