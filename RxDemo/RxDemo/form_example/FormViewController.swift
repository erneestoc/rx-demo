//
//  FormViewController.swift
//  RxDemo
//
//  Created by Ernesto Cambuston on 10/3/18.
//  Copyright © 2018 Ernesto Cambuston. All rights reserved.
//

import UIKit
import RxSwift

class FormViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    private var disposeBag:DisposeBag? = DisposeBag()
    
    private let viewModel = FormViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let disposeBag = disposeBag else { return }
        emailTextField.rx
            .text
            .orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)

        passwordTextField.rx
            .text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)

        viewModel.isValid
            .drive(submitButton.rx.isEnabled)
            .disposed(by: disposeBag)

        submitButton.rx
            .tap
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap(viewModel.attemptLogin)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: logInSuccess)
            .disposed(by: disposeBag)
    }
    
    private func logInSuccess() {
        print("🤠!")
    }
    
    deinit {
        disposeBag = nil
    }
}

