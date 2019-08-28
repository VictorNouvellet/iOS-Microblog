//
//  UserDetailPostCell.swift
//  Microblog
//
//  Created by Victor on 26/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation
import UIKit

class UserDetailPostCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewLabel: UILabel!
    
    override var isHighlighted: Bool {
        willSet {
            contentView.backgroundColor = newValue ? .lightGray : .white
        }
    }
    
    
    
    func configure(withPost post: PostModel) {
        self.titleLabel.text = post.title
        self.previewLabel.text = post.body
    }
}
