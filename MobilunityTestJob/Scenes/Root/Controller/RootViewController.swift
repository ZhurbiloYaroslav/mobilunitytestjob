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
    func update(childVC: UIViewController)
}
    
class RootViewController: UIViewController {
    private var current: UIViewController?
    private var output: RootViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.didLoad()
    }
    
    private func set(newChildVC: UIViewController) {
        if current != nil {
            add(newChildVC: newChildVC)
            current?.willMove(toParent: nil)
            current?.view.removeFromSuperview()
            current?.removeFromParent()
            current = newChildVC
        } else {
            add(newChildVC: newChildVC)
            current = newChildVC
        }
        
    }
    
    private func add(newChildVC: UIViewController) {
        addChild(newChildVC)
        newChildVC.view.frame = view.bounds
        view.addSubview(newChildVC.view)
        newChildVC.didMove(toParent: self)
    }

}

extension RootViewController: RootViewInput {
    func attach(output: RootViewOutput) {
        self.output = output
    }
    
    func update(childVC: UIViewController) {
        set(newChildVC: childVC)
    }
}
