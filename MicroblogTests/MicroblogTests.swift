//
//  MicroblogTests.swift
//  MicroblogTests
//
//  Created by Victor on 24/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import XCTest
import Moya
import RxSwift
import RxBlocking
@testable import Microblog

class MicroblogTests: XCTestCase {
    
    var disposeBag: DisposeBag!
    var stubbingProvider: MoyaProvider<JSONPlaceholder>!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.stubbingProvider = MoyaProvider<JSONPlaceholder>(
            endpointClosure: testEndpointClosure,
            stubClosure: MoyaProvider.immediatelyStub
        )
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.stubbingProvider = nil
    }
    
    func testGetUsers() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(try UserService(provider: stubbingProvider).getUsers().toBlocking().single().count, 10)
    }
    
    func testGetPostsForUser() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(try UserService(provider: stubbingProvider).getPosts(forUserId: 1).toBlocking().single().count, 100)
    }
    
    func testGetAlbumsForUser() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(try UserService(provider: stubbingProvider).getAlbums(forUserId: 1).toBlocking().single().count, 100)
    }
}
