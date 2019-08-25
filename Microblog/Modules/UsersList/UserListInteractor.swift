//
//  UserListInteractor.swift
//  Microblog
//
//  Created by Victor on 24/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation

final class UserListInteractor {
    
    // MARK: - Injected vars
    
    weak var view: UserListViewController!
    
    // MARK: - Internal vars
    
    private(set) var users = [UserModel].init(repeating: UserModel(), count: 3)
}
