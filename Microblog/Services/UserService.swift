//
//  UserService.swift
//  Microblog
//
//  Created by Victor on 25/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation
import Moya
import RxSwift

protocol UserServiceInterface {
    func getUsers() -> Single<[UserModel]>
}

class UserService: UserServiceInterface {
    
    private let provider: MoyaProvider<JSONPlaceholder>
    
    init(provider: MoyaProvider<JSONPlaceholder> = MoyaProvider<JSONPlaceholder>()) {
        self.provider = provider
    }
    
    func getUsers() -> Single<[UserModel]> {
        return provider.rx
            .request(.users)
            .map([UserModel].self)
    }
}
