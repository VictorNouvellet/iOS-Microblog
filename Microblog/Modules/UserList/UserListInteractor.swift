//
//  UserListInteractor.swift
//  Microblog
//
//  Created by Victor on 24/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class UserListInteractor {
    
    // MARK: - Injected vars
    
    weak var view: UserListViewController!
    var service: UserService!
    
    // MARK: - Private vars
    
    private var users = BehaviorSubject<[UserModel]>(value: [])
    private let disposeBag = DisposeBag()
    
    // MARK: - Internal vars
    
    var model: Observable<UserListViewModel> {
        return users.map({ usersModels in
            UserListViewModel(
                title: NSLocalizedString("users", comment: "").localizedCapitalized,
                users: usersModels
            )
        })
    }
}

// MARK: - Internal methods

extension UserListInteractor {
    func onViewDidLoad() {
        self.refreshData()
            .subscribe(onSuccess: { _ in }, onError: { _ in })
            .disposed(by: self.disposeBag)
    }
    
    func onRefresh() -> Driver<Bool> {
        return self.refreshData()
            .map({ _ in return true })
            .asDriver(onErrorJustReturn: false)
    }
}

// MARK: - Private methods

private extension UserListInteractor {
    func refreshData() -> Single<[UserModel]> {
        return self.fetchData()
            .do(
                onSuccess: { [weak self] users in
                    self?.users.onNext(users)
                }, onError: { [weak self] error in
                    self?.users.onNext([])
                }
            )
    }
    
    func fetchData() -> Single<[UserModel]> {
        return self.service.getUsers()
    }
}
