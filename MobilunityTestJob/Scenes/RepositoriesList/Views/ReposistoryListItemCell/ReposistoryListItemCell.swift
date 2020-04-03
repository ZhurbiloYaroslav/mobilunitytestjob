//
//  ReposistoryListItemCell.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import BonMot
import Kingfisher

class ReposistoryListItemCell: UICollectionViewCell {

    @IBOutlet weak var repositoryImage: UIImageView!
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var repositoryDetails: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        repositoryImage.image = R.image.repository_decoupled()
        repositoryName.attributedText = nil
        repositoryDetails.attributedText = nil
    }

    func configure(with model: RepositoriesListViewModelProtocol) {
        repositoryName.attributedText = model.repositoryName.styled(with: Self.titleStyle)
        repositoryDetails.numberOfLines = 3
        repositoryDetails.lineBreakMode = .byWordWrapping
        repositoryDetails.attributedText = model.repositoryDetails.styled(with: Self.subtitleStyle)
        repositoryImage.kf.setImage(with: model.repositoryImageUrl)
    }
    
    static func height(for width: CGFloat, title: String?, subtitle: String?) -> CGFloat {
        let availableWidth = width - paddings.left - paddings.right
        let size = CGSize(width: availableWidth, height: .greatestFiniteMagnitude)
        let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
        let titleHeight = (title ?? "").styled(with: titleStyle).boundingRect(with: size, options: options, context: nil).height
        let subtitleHeight = (subtitle ?? "").styled(with: subtitleStyle).boundingRect(with: size, options: options, context: nil).height
        return max(minHeight, paddings.top + ceil(titleHeight + subtitleHeight) + paddings.bottom)
    }

}

// MARK: - Cell styles
extension ReposistoryListItemCell {
    private static let minHeight: CGFloat = {
        return 8 /* Padding top */
            + 60 /* Image height */
            + 8 /* Padding bottom */
    }()
    private static let paddings: UIEdgeInsets = {
        let verticalSpaces: CGFloat = {
            8 /* Space between labels */
        }()
        let horizontalSpaces: CGFloat = {
            8 /* Space between image and labels */
        }()
        return UIEdgeInsets(top: 8,
                            left: 16,
                            bottom: verticalSpaces + 8,
                            right: horizontalSpaces + 16)
    }()
    private static let titleStyle: StringStyle = {
        StringStyle(.font(UIFont.defaultFont(.medium, size: 16)),
                    .color(.darkGray))
    }()
    private static let subtitleStyle: StringStyle = {
        StringStyle(.font(UIFont.defaultFont(.regular, size: 14)),
                    .color(.darkGray))
    }()
}
