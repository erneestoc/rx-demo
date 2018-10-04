//
//  FormViewModel.swift
//  RxDemo
//
//  Created by Ernesto Cambuston on 10/3/18.
//  Copyright © 2018 Ernesto Cambuston. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct FormViewModel {
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")

    var isValid:Driver<Bool> {
        return Observable<Bool>.combineLatest(
            email.asObservable(),
            password.asObservable(),
            resultSelector: validateEmailAndPassword
        ).asDriver(onErrorJustReturn: false)
    }
    
    private func validateEmailAndPassword(email:String, password:String) -> Bool {
        return isValidEmail(testStr: email) && !password.isEmpty
    }
    
    private func isValidEmail(testStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func attemptLogin()->Observable<()> {
        return Observable<()>.create { observer in
            sleep(1)
            observer.onNext(())
            return Disposables.create()
        }
    }
}
