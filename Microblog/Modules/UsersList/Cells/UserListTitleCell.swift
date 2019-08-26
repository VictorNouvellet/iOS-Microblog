//
//  UserListTitleCell.swift
//  Microblog
//
//  Created by Victor on 24/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import UIKit

final class UserListTitleCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(withTitle title: String) {
        self.titleLabel.text = title
    }
}
