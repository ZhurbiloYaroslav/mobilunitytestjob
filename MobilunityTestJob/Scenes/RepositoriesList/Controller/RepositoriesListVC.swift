//
//  RepositoriesListVC.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

protocol RepositoriesListViewInput: class, Presentable {
    func attach(output: RepositoriesListViewOutput)
}

class RepositoriesListVC: UIViewController {

    private var output: RepositoriesListViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        output?.didLoad()
    }

}

extension RepositoriesListVC: RepositoriesListViewInput {
    func attach(output: RepositoriesListViewOutput) {
        self.output = output
    }
}
