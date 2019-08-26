//
//  Encodable+Dictionary.swift
//  Microblog
//
//  Created by Victor on 27/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation

extension Encodable {
    func asDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
