//
//  UserListRouter.swift
//  Microblog
//
//  Created by Victor on 26/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation

class UserListRouter {
    
    weak var view: UserListViewController!
    
    func pushUserDetail(forUser user: UserModel) {
        guard let detailVC = UserDetailBuilder.getView(user: user) else { return }
        self.view.navigationController?.pushViewController(detailVC, animated: true)
    }
}
