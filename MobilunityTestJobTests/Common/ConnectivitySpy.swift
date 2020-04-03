//
//  ConnectivitySpy.swift
//  MobilunityTestJobTests
//
//  Created by Yaroslav Zhurbilo on 03.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import XCTest
@testable import MobilunityTestJob

class ConnectivitySpy: ConnectivityProtocol {
    var isConnectedToInternet: Bool = true
}
