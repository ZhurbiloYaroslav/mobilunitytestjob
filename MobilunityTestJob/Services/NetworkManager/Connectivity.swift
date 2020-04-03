//
//  Connectivity.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 03.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
