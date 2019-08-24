//
//  UserListBuilder.swift
//  Microblog
//
//  Created by Victor on 24/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation
import UIKit

final class UserListBuilder {
    
    static let name = "UserList"
    
    static var storyboard: UIStoryboard { return UIStoryboard(name:self.name, bundle: Bundle.main) }
    
    static func getView() -> UserListViewController? {
        let view = self.storyboard.instantiateInitialViewController() as? UserListViewController
        let interactor = UserListInteractor()
        interactor.view = view
        view?.interactor = interactor
        return view
    }
}
