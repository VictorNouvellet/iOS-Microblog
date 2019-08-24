//
//  UICollectionView+Dequeue.swift
//  Microblog
//
//  Created by Victor on 24/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
    func register<T: UICollectionViewCell>(cellWithClass name: T.Type) {
        let name = String(describing: name)
        self.register(UINib(nibName: name, bundle: nil), forCellWithReuseIdentifier: name)
    }
}
