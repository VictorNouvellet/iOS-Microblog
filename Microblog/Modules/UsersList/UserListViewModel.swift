//
//  UserListViewModel.swift
//  Microblog
//
//  Created by Victor on 26/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

struct UserListViewModel {
    let title: String
    let users: [UserModel]
}

enum UserListSectionData {
    case title(String)
    case user(UserModel)
}

struct UserListSection {
    var items: [UserListSectionData]
}

extension UserListSection: SectionModelType {
    typealias Item = UserListSectionData
    
    init(original: UserListSection, items: [UserListSectionData]) {
        self = original
        self.items = items
    }
}
