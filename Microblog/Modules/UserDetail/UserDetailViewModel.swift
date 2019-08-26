//
//  UserDetailViewModel.swift
//  Microblog
//
//  Created by Victor on 26/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

struct UserDetailViewModel {
    let user: UserModel
    let posts: [PostModel]
}

enum UserDetailSectionData {
    case post(PostModel)
}

struct UserDetailSection {
    var items: [UserDetailSectionData]
}

extension UserDetailSection: SectionModelType {
    typealias Item = UserDetailSectionData
    
    init(original: UserDetailSection, items: [UserDetailSectionData]) {
        self = original
        self.items = items
    }
}
