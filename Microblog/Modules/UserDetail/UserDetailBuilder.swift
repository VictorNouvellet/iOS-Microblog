//
//  UserDetailBuilder.swift
//  Microblog
//
//  Created by Victor on 26/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation
import UIKit

final class UserDetailBuilder {
    
    static let name = "UserDetail"
    
    static var storyboard: UIStoryboard { return UIStoryboard(name:self.name, bundle: Bundle.main) }
    
    static func getView(user: UserModel, service: UserService = UserService()) -> UserDetailViewController? {
        let view = self.storyboard.instantiateInitialViewController() as? UserDetailViewController
        let interactor = UserDetailInteractor()
        interactor.user = user
        interactor.service = service
        interactor.view = view
        view?.interactor = interactor
        let router = UserDetailRouter()
        router.view = view
        view?.router = router
        return view
    }
}
