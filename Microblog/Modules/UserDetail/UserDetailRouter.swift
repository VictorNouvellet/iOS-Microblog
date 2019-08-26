//
//  UserDetailRouter.swift
//  Microblog
//
//  Created by Victor on 27/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation

class UserDetailRouter {
    
    weak var view: UserDetailViewController!
    
    func pushPostComment(forPost post: PostModel) {
        guard let commentFormVC = CommentFormBuilder.getView(post: post) else { return }
        self.view.navigationController?.pushViewController(commentFormVC, animated: true)
    }
}
