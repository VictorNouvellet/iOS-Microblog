//
//  JSONPlaceholder+TestSampleData.swift
//  MicroblogTests
//
//  Created by Victor on 25/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation
import XCTest
import Moya
@testable import Microblog

extension JSONPlaceholder: TestableTargetType {
    var testSampleData: Data {
        switch self {
        case .users:
            return stubbedResponse("users")
        case .posts:
            return stubbedResponse("users-1-posts")
        case .albums:
            return stubbedResponse("users-1-albums")
        }
    }
}

