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
        row.title = "Body"
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
        row.title = "Email"
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
    }
    
    func setupForm() {
        sendButton.onCellSelection({ [weak self] (cell, row) in
            self?.sendButtonTapped()
        })
        
        form
            +++ Section("Post")
            <<< postTitleRow
            <<< postBodyRow
            +++ Section("Comment")
            <<< commentNameRow
            <<< commentEmailRow
            <<< commentBodyRow
            <<< sendButton
    }
}

// MARK: - Private methods

private extension CommentFormViewController {
    func sendButtonTapped() {
        let rowsToValidate = [commentNameRow, commentEmailRow, commentBodyRow]
        rowsToValidate.forEach({ $0.validate() })
        guard rowsToValidate.map({ $0.isValid }).reduce(true, { $0 && $1 }) else { return }
        guard let name = commentNameRow.value, name.isEmpty == false else { return }
        guard let email = commentEmailRow.value, email.isEmpty == false else { return }
        guard let body = commentBodyRow.value, body.isEmpty == false else { return }
        self.interactor.onSendComment(name: name, email: email, body: body)
            .subscribe(
                onCompleted: { [weak self] in
                    self?.showAlert(success: true)
                },
                onError: { [weak self] error in
                    self?.showAlert(success: false, message: error.localizedDescription)
                }
            )
            .disposed(by: self.disposeBag)
    }
    
    func showAlert(success: Bool, message: String? = nil) {
        let title: String
        if success {
            title = NSLocalizedString("Comment sent successfully!", comment: "")
        } else {
            title = NSLocalizedString("Error sending the comment", comment: "")
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true)
    }
}
