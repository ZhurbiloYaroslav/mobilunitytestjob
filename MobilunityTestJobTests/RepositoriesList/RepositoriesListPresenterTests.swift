//
//  RepositoriesListPresenterTests.swift
//  MobilunityTestJobTests
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import MobilunityTestJob

extension RepositoriesListPresenterTests {
    struct Constants {
        let wrongAmount: Int = 99
    }
}

class RepositoriesListPresenterTests: XCTestCase {
    
    private var sut: RepositoriesListViewOutput!
    private var routerSpy: RepositoriesListRouterSpy!
    private var viewSpy: RepositoriesListViewSpy!
    private var connectivitySpy: ConnectivitySpy!
    private var const = Constants()

    override func setUp() {
        super.setUp()
        
        OHHTTPStubs.setEnabled(true)
        let connectivitySpy = ConnectivitySpy()
        let networkManager = NetworkManager(connectivity: connectivitySpy)
        sut = RepositoriesListPresenter(networkManager: networkManager)
        routerSpy = RepositoriesListRouterSpy()
        viewSpy = RepositoriesListViewSpy()
        viewSpy.attach(output: sut)
        sut.attach(view: viewSpy)
        sut.attach(router: routerSpy)
    }

    override func tearDown() {
        sut = nil
        routerSpy = nil
        viewSpy = nil
        OHHTTPStubs.removeAllStubs()
        OHHTTPStubs.setEnabled(false)
        
        super.tearDown()
    }

    func testDidLoad_zeroRepositories_success() {
        runDidLoadSuccessWith(expectedAmount: .zero)
    }

    func testDidLoad_zeroRepositories_failure() {
        runDidLoadFailureWith(expectedAmount: .zero)
    }

    func testDidLoad_oneRepositories_success() {
        runDidLoadSuccessWith(expectedAmount: .one)
    }

    func testDidLoad_oneRepositories_failure() {
        runDidLoadFailureWith(expectedAmount: .one)
    }

    func testDidLoad_thirtyRepositories_success() {
        runDidLoadSuccessWith(expectedAmount: .thirty)
    }

    func testDidLoad_thirtyRepositories_failure() {
        runDidLoadFailureWith(expectedAmount: .thirty)
    }
    
    func testDidLoad_error_500() {
        let expectedAmount: RepositoriesAmount = .thirty
        stubLoadAllRepositories(config: expectedAmount, statusCode: 500)
        let delayExpectation = expectation(description: "Data loading")
        delayExpectation.expectedFulfillmentCount = 2
        viewSpy.onUpdateSections = { [weak delayExpectation, unowned self] sections in
            if self.isItLoadingSection(sections: sections) {
                delayExpectation?.fulfill()
            } else if self.isItErrorSection(sections: sections) {
                delayExpectation?.fulfill()
            }
        }
        sut.didLoad()
        wait(for: [delayExpectation], timeout: 5)
    }
    
    func isItLoadingSection(sections: [RepositoriesListSection]) -> Bool {
        guard sections.count == 1 else { return false }
        guard case RepositoriesListSection.Identifier.preload = sections[0].id
            else { return false }
        return true
    }
    
    func isItErrorSection(sections: [RepositoriesListSection]) -> Bool {
        guard sections.count == 1 else { return false }
        guard case RepositoriesListSection.Identifier.error = sections[0].id
            else { return false }
        return true
    }
}

extension RepositoriesListPresenterTests {
    func runDidLoadSuccessWith(expectedAmount: RepositoriesAmount) {
        stubLoadAllRepositories(config: expectedAmount)
        let delayExpectation = expectation(description: "Data loading")
        delayExpectation.expectedFulfillmentCount = 2
        viewSpy.onUpdateSections = { [weak delayExpectation, unowned self] sections in
            if self.isItLoadingSection(sections: sections) {
                delayExpectation?.fulfill()
            } else if sections.count == expectedAmount.amount {
                delayExpectation?.fulfill()
            }
        }
        sut.didLoad()
        wait(for: [delayExpectation], timeout: 5)
    }
    
    func runDidLoadFailureWith(expectedAmount: RepositoriesAmount) {
        let wrongAmount = const.wrongAmount
        stubLoadAllRepositories(config: expectedAmount)
        let delayExpectation = expectation(description: "Data loading")
        delayExpectation.expectedFulfillmentCount = 2
        viewSpy.onUpdateSections = { [weak delayExpectation, unowned self] sections in
            if self.isItLoadingSection(sections: sections) {
                delayExpectation?.fulfill()
            } else if sections.count != wrongAmount {
                delayExpectation?.fulfill()
            }
        }
        sut.didLoad()
        wait(for: [delayExpectation], timeout: 5)
    }
}

extension RepositoriesListPresenterTests {
    enum RepositoriesAmount {
        case zero
        case one
        case thirty
        var amount: Int {
            switch self {
            case .zero:
                return 0
            case .one:
                return 1
            case .thirty:
                return 30
            }
        }
    }
    
    private func stubLoadAllRepositories(config: RepositoriesAmount, statusCode: Int32 = 200) {
        stub(condition: isPath("/orgs/square/repos")) { _ in
            let path = OHPathForFile("SquareRepositories_\(config.amount).json", self.classForCoder)!
            return OHHTTPStubsResponse(fileAtPath: path, statusCode: statusCode, headers: .none)
        }
    }
}
