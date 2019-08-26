//
//  TestableTargetType.swift
//  MicroblogTests
//
//  Created by Victor on 25/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation
import Moya

protocol TestableTargetType: TargetType {
    var testSampleData: Data { get }
}

extension TestableTargetType {
    func stubbedResponse(_ resource: String) -> Data {
        let bundle = Bundle.test
        guard let path = bundle.path(forResource: resource, ofType: "json") else {
            log.severe("No resource found with name '\(resource)'")
            return Data()
        }
        do {
            return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        } catch {
            log.severe("Error when reading file \(path): \(error)")
            return Data()
        }
    }
}
