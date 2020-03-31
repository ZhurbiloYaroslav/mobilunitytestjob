//
//  UIAlertController+addActionFactory.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 31.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

extension UIAlertController {
    func addAction(actionFactory: () -> UIAlertAction) {
        addAction(actionFactory())
    }
}
