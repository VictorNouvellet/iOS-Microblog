//
//  JSONPlaceholder.swift
//  Microblog
//
//  Created by Victor on 25/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation
import Moya

enum JSONPlaceholder {
    case users
}

extension JSONPlaceholder: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com") else {
            fatalError("\(String(describing: self)): Wrong baseURL")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .users:
            return "/users"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .users:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .users:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [String : String]()
    }
}
