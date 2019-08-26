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
    
    // MARK: - Internal vars
    
    var model: UserDetailViewModel! { didSet { self.didUpdateModel(model) } }
    
    // MARK: - Private vars
    
    private let disposeBag = DisposeBag()
}

// MARK: - Internal methods

extension UserDetailInteractor {
    func onViewDidLoad() {
        self.model = UserDetailViewModel(user: self.user)
    }
}

// MARK: - Private methods

private extension UserDetailInteractor {
    /// Should not be used directly
    func didUpdateModel(_ newModel: UserDetailViewModel) {
        self.view.modelSubject.onNext(newModel)
    }
}
