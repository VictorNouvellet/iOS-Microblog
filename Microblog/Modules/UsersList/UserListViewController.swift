//
//  UserListViewController.swift
//  Microblog
//
//  Created by Victor on 24/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Injected vars
    
    var interactor: UserListInteractor!
    
    // MARK: - Section enum
    
    enum Section: Int, CaseIterable {
        case title
        case users
    }
}

// MARK: - View lifecycle

extension UserListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
}

// MARK: - Setup methods

private extension UserListViewController {
    func setup() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource methods

extension UserListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .title:
            return 1
        case .users:
            return self.interactor.users.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UICollectionViewCell() }
        switch section {
        case .title:
            let cell: UserListTitleCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .users:
            let cell: UserListUserCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(withUser: self.interactor.users[indexPath.item])
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout methods

extension UserListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let section = Section(rawValue: indexPath.section) else { return .zero }
        switch section {
        case .title:
            return CGSize(width: self.view.bounds.width, height: 90.0)
        case .users:
            return CGSize(width: self.view.bounds.width, height: 70.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section), section == .users else { return }
        
        let user = self.interactor.users[indexPath.item]
        // TODO
    }
}
