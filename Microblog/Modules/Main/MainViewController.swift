//
//  MainViewController.swift
//  Microblog
//
//  Created by Victor on 24/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import UIKit

final class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
}

// MARK: - Setup methods

private extension MainViewController {
    
    func setup() {
        self.navigationController?.isNavigationBarHidden = true
        self.viewControllers = [self.getUserListViewController()].compactMap({ $0 })
        self.tabBar.isHidden = (self.viewControllers?.count ?? 0 < 2)
    }
    
    func getUserListViewController() -> UserListViewController? {
        return UserListBuilder.getView()
    }
}

