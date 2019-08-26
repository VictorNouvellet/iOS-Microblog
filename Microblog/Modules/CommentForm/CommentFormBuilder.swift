//
//  CommentFormBuilder.swift
//  Microblog
//
//  Created by Victor on 27/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation
import UIKit

final class CommentFormBuilder {
    
    static let name = "CommentForm"
    
    static var storyboard: UIStoryboard { return UIStoryboard(name:self.name, bundle: Bundle.main) }
    
    static func getView(post: PostModel, service: UserService = UserService()) -> CommentFormViewController? {
        let view = self.storyboard.instantiateInitialViewController() as? CommentFormViewController
        let interactor = CommentFormInteractor()
        interactor.post = post
        interactor.service = service
        interactor.view = view
        view?.interactor = interactor
        let router = CommentFormRouter()
        router.view = view
        view?.router = router
        return view
    }
}
