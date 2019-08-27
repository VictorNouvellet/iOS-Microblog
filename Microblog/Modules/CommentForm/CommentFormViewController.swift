//
//  CommentFormViewController.swift
//  Microblog
//
//  Created by Victor on 27/08/2019.
//  Copyright © 2019 Victor Nouvellet. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import RxSwift
import RxCocoa

class CommentFormViewController: FormViewController {
    
    // MARK: - Injected vars
    
    var interactor: CommentFormInteractor!
    var router: CommentFormRouter!
    
    // MARK: - Private vars
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Internal vars
    
    var modelSubject = PublishSubject<CommentFormViewModel>()
    
    // MARK: - Eureka rows
    
    let postTitleRow = LabelRow(){ row in
        row.title = NSLocalizedString("Title", comment: "")
        row.value = nil
    }
    
    let postBodyRow = TextAreaRow(){ row in
        row.title = NSLocalizedString("Body", comment: "")
        row.placeholder = NSLocalizedString("Loading...", comment: "")
        row.value = nil
        row.disabled = true
    }
    
    let commentNameRow = NameRow(){ row in
        row.title = NSLocalizedString("Name", comment: "")
        row.placeholder = NSLocalizedString("John Appleseed", comment: "")
        row.value = nil
        row.add(rule: RuleRequired())
        row.validationOptions = .validatesOnChangeAfterBlurred
    }
    .cellUpdate { cell, row in
        if !row.isValid {
            cell.titleLabel?.textColor = .red
        }
    }
    
    let commentEmailRow = EmailRow(){ row in
        row.title = NSLocalizedString("Email", comment: "")
        row.placeholder = NSLocalizedString("Your email", comment: "")
        row.value = nil
        row.add(rule: RuleRequired())
        row.add(rule: RuleEmail())
        row.validationOptions = .validatesOnChangeAfterBlurred
    }
    .cellUpdate { cell, row in
        if !row.isValid {
            cell.titleLabel?.textColor = .red
        }
    }
    
    let commentBodyRow = TextAreaRow(){ row in
        row.title = NSLocalizedString("Comment", comment: "")
        row.placeholder = NSLocalizedString("Enter your comment here", comment: "")
        row.add(rule: RuleRequired())
        row.validationOptions = .validatesOnChangeAfterBlurred
    }
    .cellUpdate { cell, row in
        if !row.isValid {
            cell.placeholderLabel?.textColor = UIColor.red.withAlphaComponent(0.22)
        }
    }
    
    var sendButton = ButtonRow() { row in
        row.title = NSLocalizedString("Send comment", comment: "")
    }
}

// MARK: - View lifecycle

extension CommentFormViewController {
    
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

private extension CommentFormViewController {
    func setup() {
        setupForm()
        setupRx()
    }
    
    func setupForm() {
        sendButton.onCellSelection({ [weak self] (cell, row) in
            cell.isUserInteractionEnabled = false
            row.disabled = true
            row.evaluateDisabled()
            self?.sendButtonTapped()
        })
        
        form
            +++ Section(NSLocalizedString("Post", comment: ""))
            <<< postTitleRow
            <<< postBodyRow
            +++ Section(NSLocalizedString("Comment", comment: ""))
            <<< commentNameRow
            <<< commentEmailRow
            <<< commentBodyRow
            <<< sendButton
    }
    
    func setupRx() {
        self.interactor.modelSubject
            .subscribe(onNext: { [weak self] model in
                self?.updateView(withModel: model)
            })
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Private methods

private extension CommentFormViewController {
    func updateView(withModel model: CommentFormViewModel) {
        self.postTitleRow.value = model.post.title
        self.postBodyRow.value = model.post.body
    }
    
    func sendButtonTapped() {
        self.validate()
            .flatMapCompletable { [weak self] validatedInfo -> Completable in
                guard let self = self else { return Completable.empty() }
                return self.interactor
                    .onSendComment(name: validatedInfo.name, email: validatedInfo.email, body: validatedInfo.body)
                    .andThen(Single<(Bool, String?)>.just((true, nil)))
                    .catchError({ error in return Single<(Bool, String?)>.just((false, error.localizedDescription)) })
                    .flatMapCompletable({ [weak self] result in
                        guard let self = self else { return Completable.empty() }
                        return self.showAlert(success: result.0, message: result.1).asCompletable()
                    })
            }
            .do(onDispose: { [weak self] in
                self?.sendButton.disabled = false
                self?.sendButton.evaluateDisabled()
                self?.sendButton.cell.isUserInteractionEnabled = true
            })
            .subscribe(onCompleted: { [weak self] in
                self?.commentBodyRow.value = nil
            })
            .disposed(by: self.disposeBag)
    }
    
    func validate() -> Single<(name: String, email: String, body: String)> {
        let validationErrors = form.validate(includeDisabled: false)
        guard validationErrors.isEmpty else {
            return Single<(name: String, email: String, body: String)>.error(CommentFormError.validationErrors(validationErrors))
        }
        // Never trust the user input (or Eureka in this case)
        guard let name = commentNameRow.value, name.isEmpty == false else {
            return Single<(name: String, email: String, body: String)>.error(CommentFormError.emptyName)
        }
        guard let email = commentEmailRow.value, email.isEmpty == false else {
            return Single<(name: String, email: String, body: String)>.error(CommentFormError.emptyEmail)
        }
        guard let body = commentBodyRow.value, body.isEmpty == false else {
            return Single<(name: String, email: String, body: String)>.error(CommentFormError.emptyBody)
        }
        return Single<(name: String, email: String, body: String)>.just((name: name, email: email, body: body))
    }
    
    func showAlert(success: Bool, message: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let title: String
        if success {
            title = NSLocalizedString("Comment sent successfully!", comment: "")
        } else {
            title = NSLocalizedString("Error sending the comment", comment: "")
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alertController.addAction(defaultAction)
        present(alertController, animated: true)
    }
    
    func showAlert(success: Bool, message: String? = nil) -> Single<UIAlertAction> {
        return Single<UIAlertAction>.create { single in
            self.showAlert(success: success, message: message, handler: { alert in
                single(.success(alert))
            })
            return Disposables.create()
        }
    }
}

enum CommentFormError: Error {
    case emptyName
    case emptyEmail
    case emptyBody
    case validationErrors([ValidationError])
}
