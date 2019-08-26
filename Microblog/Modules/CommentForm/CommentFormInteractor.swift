//
//  CommentFormInteractor.swift
//  Microblog
//
//  Created by Victor on 27/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class CommentFormInteractor {
    
    // MARK: - Injected vars
    
    weak var view: CommentFormViewController!
    var service: UserService!
    var post: PostModel!
    
    // MARK: - Private vars
    
    private let disposeBag = DisposeBag()
}

// MARK: - Internal methods

extension CommentFormInteractor {
    func onViewDidLoad() {
        // Nothing to do
    }
    
    func onSendComment(name: String, email: String, body: String) -> Completable {
        let comment = CommentModel(
            postId: self.post.id,
            name: name,
            email: email,
            body: body
        )
        return self.sendComment(comment)
    }
}

// MARK: - Private methods

private extension CommentFormInteractor {
    func sendComment(_ comment: CommentModel) -> Completable {
        return self.service.postComment(comment: comment)
    }
}
