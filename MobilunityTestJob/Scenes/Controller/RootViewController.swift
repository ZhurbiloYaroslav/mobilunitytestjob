//
//  RootViewController.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

protocol RootViewInput: class, Presentable {
    func attach(output: RootViewOutput)
}
    
class RootViewController: UIViewController {
    private var output: RootViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        output?.didLoad()
    }

}

extension RootViewController: RootViewInput {
    func attach(output: RootViewOutput) {
        self.output = output
    }
}
