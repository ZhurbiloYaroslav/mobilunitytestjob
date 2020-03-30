//
//  AppDependencyContainer.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import Swinject

class AppDependencyContainer {
    private lazy var appDIContainer: Container = {
        Container { container in
            container.register(RootDIContainer.self) { resolver -> RootDIContainer in
                RootDIContainer(parentContainer: container)
            }
            container.register(NetworkManagerProtocol.self) { resolver -> NetworkManagerProtocol in
                return NetworkManager()
            }
        }
    }()
    
    func makeRootScreen() -> RootScreen {
        appDIContainer.resolve(RootDIContainer.self)!.makeRootScreen()
    }
}
