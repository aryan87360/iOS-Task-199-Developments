//
//  Assignment_SolutionUITests.swift
//  Assignment SolutionUITests
//
//  Created by Aryan Sharma on 19/05/24.
//

import XCTest

class Assignment_SolutionUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
