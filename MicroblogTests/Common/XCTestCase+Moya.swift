//
//  XCTestCase+Moya.swift
//  MicroblogTests
//
//  Created by Victor on 25/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation
import XCTest
import Moya

extension XCTestCase {
    func testEndpointClosure<T: TestableTargetType>(_ target: T) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(200, target.testSampleData) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
}
