//
//  PlaceholderCellButtonModel.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 02.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import BonMot

protocol PlaceholderCellButtonModelling {
    var title: NSAttributedString { get }
    var backgroundColor: UIColor { get }
    var buttonAction: () -> Void { get }
}

extension PlaceholderCellButtonModelling {
    static var textStyle: StringStyle {
        StringStyle(.font(UIFont.defaultFont(.regular, size: 14)),
                    .color(.white))
    }
}

struct PlaceholderCellErrorButtonModel: PlaceholderCellButtonModelling {
    var title: NSAttributedString {
        "Try again later".styled(with: Self.textStyle)
    }
    var backgroundColor: UIColor { .red }
    var buttonAction: () -> Void
}

struct PlaceholderCellEmptyButtonModel: PlaceholderCellButtonModelling {
    var title: NSAttributedString {
        "Reload".styled(with: Self.textStyle)
    }
    var backgroundColor: UIColor { .blue }
    var buttonAction: () -> Void
}
