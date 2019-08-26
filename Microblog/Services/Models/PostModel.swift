//
//  PostModel.swift
//  Microblog
//
//  Created by Victor on 26/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation

typealias PostId = Int

/// Entity in list retrieved from https://jsonplaceholder.typicode.com/posts

struct PostModel: Codable {
    // Variable names are important for snake case decoding strategy
    let id: PostId
    let userId: UserId
    let title: String
    let body: String
}
