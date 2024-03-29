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
    
    func getPosts(forUserId userId: UserId) -> Single<[PostModel]> {
        return provider.rx
            .request(.posts(userId: userId))
            .map([PostModel].self)
    }
    
    func getAlbums(forUserId userId: UserId) -> Single<[AlbumModel]> {
        return provider.rx
            .request(.albums(userId: userId))
            .map([AlbumModel].self)
    }
    
    func postComment(comment: CommentModel) -> Completable {
        return provider.rx
            .request(.postComment(comment: comment))
            .asCompletable()
    }

}
