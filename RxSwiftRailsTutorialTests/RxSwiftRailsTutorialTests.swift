//
//  RxSwiftRailsTutorialTests.swift
//  RxSwiftRailsTutorialTests
//
//  Created by Kazuhiro Furue on 2018/05/02.
//  Copyright © 2018年 Kazuhiro Furue. All rights reserved.
//

import XCTest
@testable import RxSwiftRailsTutorial

class RxSwiftRailsTutorialTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        SampleAppClientAPI.customHeaders["Authorization"]
            = "Bearer 5c1391cdfee16ffe5e380b41ce3e58dbbf30bc16a597542ac0289f4f936a6d91"

        let imageDownloadExpectation: XCTestExpectation? =
            self.expectation(description: "download Image")

        FeedAPI.getApiV1Feed { (microposts, error) in
            print(microposts as Any)
            print(error as Any)
            imageDownloadExpectation?.fulfill()
        }
        waitForExpectations(timeout: 5, handler:nil)
    }

    func testJsonParse() {
        let json = """
[{\"id\":300,\"content\":\"Voluptate tenetur quia culpa explicabo et.\",\"user_id\":6,\"picture\":{\"url\":null}},{\"id\":299,\"content\":\"Voluptate tenetur quia culpa explicabo et.\",\"user_id\":5,\"picture\":{\"url\":null}},{\"id\":298,\"content\":\"Voluptate tenetur quia culpa explicabo et.\",\"user_id\":4,\"picture\":{\"url\":null}},{\"id\":297,\"content\":\"Voluptate tenetur quia culpa explicabo et.\",\"user_id\":3,\"picture\":{\"url\":null}},{\"id\":295,\"content\":\"Voluptate tenetur quia culpa explicabo et.\",\"user_id\":1,\"picture\":{\"url\":null}},{\"id\":294,\"content\":\"Mollitia nemo earum minus ad inventore.\",\"user_id\":6,\"picture\":{\"url\":null}}]
"""

        let decoder = JSONDecoder()
        var returnedDecodable: [Micropost]? = nil

        do {
            returnedDecodable = try decoder.decode([Micropost].self, from: json.data(using: String.Encoding.utf8)!)
        } catch {
            let returnedError = error
            print(returnedError)
            assertionFailure()
        }
        XCTAssertNotNil(returnedDecodable, "Dcode failed")
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
