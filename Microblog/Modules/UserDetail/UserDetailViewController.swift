//
//  UserDetailViewController.swift
//  Microblog
//
//  Created by Victor on 26/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import RxSwift
import RxCocoa
import CoreLocation

final class UserDetailViewController: FormViewController {
    
    // MARK: - Injected vars
    
    var interactor: UserDetailInteractor!
    
    // MARK: - Private vars
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Internal vars
    
    var modelSubject = PublishSubject<UserDetailViewModel>()
    
    // MARK: - Rows
    
    var nameRow = LabelRow() { row in
        row.title = NSLocalizedString("name", comment: "").localizedCapitalized
        row.value = nil
    }
    
    var usernameRow = LabelRow() { row in
        row.title = NSLocalizedString("username", comment: "").localizedCapitalized
        row.value = nil
    }
    
    var emailRow = LabelRow() { row in
        row.title = NSLocalizedString("email", comment: "").localizedCapitalized
        row.value = nil
    }
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
        setupForm()
    }
    
    func setupForm() {
        form
            +++ Section(NSLocalizedString("User Information", comment: ""))
            <<< nameRow
            <<< usernameRow
            <<< emailRow
    }
    
    func setupRx() {
        self.modelSubject.subscribe(onNext: { [weak self] model in
            guard let self = self else { return }
            self.nameRow.value = model.user.name
            self.usernameRow.value = model.user.username
            self.emailRow.value = model.user.email
            
        }).disposed(by: self.disposeBag)
    }
}

// MARK: - Private methods

private extension UserDetailViewController {

}
