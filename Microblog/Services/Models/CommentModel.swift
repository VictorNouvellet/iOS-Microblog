//
//  CommentModel.swift
//  Microblog
//
//  Created by Victor on 27/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation

typealias CommentId = Int

/// Entity in list retrieved from https://jsonplaceholder.typicode.com/comments

struct CommentModel: Codable {
    let id: CommentId
    let postId: PostId
    let name: String
    let email: String
    let body: String
}

extension CommentModel {
    /// Constructor to use for local comment creation only
    init(postId: PostId, name: String, email: String, body: String) {
        self.id = Int.random(in: 1000 ..< 10000)
        self.postId = postId
        self.name = name
        self.email = email
        self.body = body
    }
}
