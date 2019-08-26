//
//  AlbumModel.swift
//  Microblog
//
//  Created by Victor on 26/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation

typealias AlbumId = Int

/// Entity in list retrieved from https://jsonplaceholder.typicode.com/albums

struct AlbumModel: Codable {
    // Variable names are important for snake case decoding strategy
    let id: AlbumId
    let userId: UserId
    let title: String
}
