//
//  UserDetailViewController.swift
//  Microblog
//
//  Created by Victor on 26/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class UserDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Injected vars
    
    var interactor: UserDetailInteractor!
    var router: UserDetailRouter!
    
    // MARK: - Private vars
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Section enum
    
    enum Section: Int, CaseIterable {
        case posts
    }
}

// MARK: - View lifecycle

extension UserDetailViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.interactor.onViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}

// MARK: - Setup methods

private extension UserDetailViewController {
    func setup() {
        setupCollectionViewDatasource()
        setupCollectionViewLayoutDelegate()
        setupCellSelection()
    }
    
    func setupCollectionViewDatasource() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<UserDetailSection>(
            configureCell: { dataSource, collectionView, indexPath, item in
                switch item {
                case .post(let post):
                    let cell: UserDetailPostCell = collectionView.dequeueReusableCell(for: indexPath)
                    cell.configure(withPost: post)
                    return cell
                }
        })
        
        self.interactor.model
            .map { (model: UserDetailViewModel) -> [UserDetailSection] in
                let postsSection = UserDetailSection(items: model.posts.map({ .post($0) }))
                return [postsSection]
            }
            .bind(to: self.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    func setupCollectionViewLayoutDelegate() {
        self.collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func setupCellSelection() {
        self.collectionView.rx.modelSelected(UserDetailSectionData.self)
            .subscribe(onNext: { model in
                switch model {
                case .post(let post):
                    self.router.pushPostComment(forPost: post)
                }
            })
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Private methods

private extension UserDetailViewController {

}

// MARK: - UICollectionViewDelegateFlowLayout methods

extension UserDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let section = Section(rawValue: indexPath.section) else { return .zero }
        switch section {
        case .posts:
            return CGSize(width: self.view.bounds.width, height: 70.0)
        }
    }
}
