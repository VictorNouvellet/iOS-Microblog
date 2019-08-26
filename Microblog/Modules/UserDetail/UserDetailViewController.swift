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
import CoreLocation

final class UserDetailViewController: UIViewController {
    
    // MARK: - Injected vars
    
    var interactor: UserDetailInteractor!
    
    // MARK: - Private vars
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Internal vars
    
    var modelSubject = PublishSubject<UserDetailViewModel>()
    
}

// MARK: - View lifecycle

extension UserDetailViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.interactor.onViewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - Setup methods

private extension UserDetailViewController {
    func setup() {
        self.navigationController?.isNavigationBarHidden = false
        setupRx()
    }
    
    func setupRx() {
        self.modelSubject.subscribe(onNext: { [weak self] model in
            guard let self = self else { return }
            
            
        }).disposed(by: self.disposeBag)
    }
}

// MARK: - Private methods

private extension UserDetailViewController {

}
