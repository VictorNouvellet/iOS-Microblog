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
    case posts(userId: UserId)
    case albums(userId: UserId)
    case postComment(comment: CommentModel)
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
        case .posts(let userId):
            return "/users/\(userId)/posts"
        case .albums(let userId):
            return "/users/\(userId)/albums"
        case .postComment:
            return "/comments"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .users,
             .posts,
             .albums:
            return .get
        case .postComment:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .users,
             .posts,
             .albums:
            return .requestPlain
        case .postComment(comment: let comment):
            var commentDict: [String: Any] = comment.asDictionary() ?? [:]
            commentDict.removeValue(forKey: "id")
            return .requestParameters(parameters: commentDict, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .users,
             .posts,
             .albums:
            return [String : String]()
        case .postComment:
            return ["Content-type": "application/json; charset=UTF-8"]
        }
    }
}
