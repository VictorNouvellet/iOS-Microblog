//
//  UserListUserCell.swift
//  Microblog
//
//  Created by Victor on 24/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import UIKit

final class UserListUserCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override var isHighlighted: Bool {
        willSet {
            contentView.backgroundColor = newValue ? .lightGray : .white
        }
    }
    
    func configure(withUser user: UserModel) {
        self.nameLabel.text = user.name
        self.usernameLabel.text = user.username
    }
}
