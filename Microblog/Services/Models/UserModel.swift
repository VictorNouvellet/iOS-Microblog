//
//  UserModel.swift
//  Microblog
//
//  Created by Victor on 24/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation

typealias UserId = Int

/// Entity in list retrieved from https://jsonplaceholder.typicode.com/users

struct UserModel: Codable {
    // Variable names are important for snake case decoding strategy
    let id: UserId
    let name: String
    let username: String
    let email: String
}
