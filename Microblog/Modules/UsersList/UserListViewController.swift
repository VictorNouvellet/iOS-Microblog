//
//  UserListViewController.swift
//  Microblog
//
//  Created by Victor on 24/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class UserListViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Injected vars
    
    var interactor: UserListInteractor!
    
    // MARK: - Private vars
    
    private let disposeBag = DisposeBag()
    
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
        self.interactor.onViewDidLoad()
    }
}

// MARK: - Setup methods

private extension UserListViewController {
    func setup() {
        setupCollectionViewDatasource()
        setupCollectionViewLayoutDelegate()
        setupCellSelection()
        setupRefreshControl()
    }
    
    func setupCollectionViewDatasource() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<UserListSection>(
            configureCell: { dataSource, collectionView, indexPath, item in
                switch item {
                case .title(let title):
                    let cell: UserListTitleCell = collectionView.dequeueReusableCell(for: indexPath)
                    cell.configure(withTitle: title)
                    return cell
                case .user(let user):
                    let cell: UserListUserCell = collectionView.dequeueReusableCell(for: indexPath)
                    cell.configure(withUser: user)
                    return cell
                }
        })
        
        self.interactor.model
            .map { (model: UserListViewModel) -> [UserListSection] in
                let titleSection = UserListSection(items: [model.title].map({ .title($0) }))
                let usersSection = UserListSection(items: model.users.map({ .user($0) }))
                return [titleSection, usersSection]
            }
            .bind(to: self.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    func setupCollectionViewLayoutDelegate() {
        self.collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func setupCellSelection() {
        self.collectionView.rx.modelSelected(UserListSectionData.self)
            .subscribe(onNext: { model in
                switch model {
                case .title:
                    break
                case .user(let user):
                    log.debug("TODO: display user \(user)")
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.rx
            .controlEvent(.valueChanged)
            .asDriver()
            .flatMapLatest({ _ in return self.interactor.onRefresh() })
            .map({ _ in return false })
            .asDriver(onErrorJustReturn: false)
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: self.disposeBag)
        
        self.collectionView.refreshControl = refreshControl
    }
}

// MARK: - Private methods

extension UserListViewController {
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        
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
}
