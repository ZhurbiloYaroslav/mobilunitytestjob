//
//  RootPresenterTests.swift
//  MobilunityTestJobTests
//
//  Created by Yaroslav Zhurbilo on 31.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import XCTest
@testable import MobilunityTestJob

class RootPresenterTests: XCTestCase {
    
    private var sut: RootViewOutput!
    private var routerSpy: RootRouterSpy!

    override func setUp() {
        super.setUp()
        
        sut = RootPresenter()
        routerSpy = RootRouterSpy()
        sut.attach(router: routerSpy)
    }

    override func tearDown() {
        sut = nil
        routerSpy = nil
        
        super.tearDown()
    }

    func testDidLoad_success() {
        let delayExpectation = expectation(description: "Waiting for 'RepositoriesList' screen as a root screen")
        routerSpy.onSetRepositoriesListAsRootScreen = { [weak delayExpectation] in
            delayExpectation?.fulfill()
        }
        sut.didLoad()
        wait(for: [delayExpectation], timeout: 5)
    }

}
