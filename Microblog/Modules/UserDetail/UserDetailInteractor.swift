//
//  UserDetailInteractor.swift
//  Microblog
//
//  Created by Victor on 26/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class UserDetailInteractor {
    
    // MARK: - Injected vars
    
    weak var view: UserDetailViewController!
    var service: UserService!
    var user: UserModel!
    
    // MARK: - Private vars
    
    private var posts = BehaviorSubject<[PostModel]>(value: [])
    private var albums = BehaviorSubject<[AlbumModel]>(value: [])
    private let disposeBag = DisposeBag()
    
    // MARK: - Internal vars
    
    var model: Observable<UserDetailViewModel> {
        return Observable<UserDetailViewModel>.combineLatest(Observable<UserModel>.just(user), self.posts) { user, posts in
            UserDetailViewModel.init(user: user, posts: posts)
        }
    }
}

// MARK: - Internal methods

extension UserDetailInteractor {
    func onViewDidLoad() {
        self.refreshPosts()
            .subscribe()
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Private methods

private extension UserDetailInteractor {
    func refreshPosts() -> Single<[PostModel]> {
        return self.fetchPosts()
            .do(
                onSuccess: { [weak self] posts in
                    self?.posts.onNext(posts)
                }, onError: { [weak self] error in
                    self?.posts.onNext([])
                }
        )
    }
    
    func fetchPosts() -> Single<[PostModel]> {
        return self.service.getPosts(forUserId: self.user.id)
    }
}
