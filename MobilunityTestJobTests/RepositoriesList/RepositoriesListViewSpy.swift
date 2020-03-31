//
//  RepositoriesListViewSpy.swift
//  MobilunityTestJobTests
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import XCTest
import UIKit
@testable import MobilunityTestJob

class RepositoriesListViewSpy: RepositoriesListViewInput {
    
    var onAttachOutput: (() -> Void)?
    func attach(output: RepositoriesListViewOutput) {
        onAttachOutput?()
    }
    
    var onUpdateSections: ((_ sections: [RepositoriesListSection]) -> Void)?
    func update(sections: [RepositoriesListSection]) {
        onUpdateSections?(sections)
    }
    
    var onShowError: ((_ title: String, _ message: String) -> Void)?
    func showError(title: String, message: String) {
        onShowError?(title, message)
    }
    
    func toPresentable() -> UIViewController {
        UIViewController()
    }
}
