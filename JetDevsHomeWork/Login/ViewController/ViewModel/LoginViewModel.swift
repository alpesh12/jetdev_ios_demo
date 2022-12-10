//
//  SignUpViewModel.swift
//  FormValidationExample
//
//  Created by Hafiz on 27/04/2021.
//

import RxCocoa
import RxSwift
import RxAlamofire
import Alamofire
import SwiftyJSON
import Foundation

class LoginViewModel {
    
    // MARK: - Properties
    var user: User? {
        didSet {
            self.didFinishFetch?()
        }
    }
    var error: String? {
        didSet { self.showAlertClosure?() }
    }
    
    private var dataService: LoginAPIService?
    
    let emailSubject = BehaviorRelay<String?>(value: "")
    let passwordSubject = BehaviorRelay<String?>(value: "")
    let disposeBag = DisposeBag()
    var viewController: UIViewController?
    
    let emailValidator = EmailValidator()
    let passwordValidator = PasswordValidator()
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var showAlertClosure: (() -> Void)?
    var didFinishFetch: (() -> Void)?
    
    // MARK: - Constructor
    init(dataService: LoginAPIService) {
        self.dataService = dataService
    }
    
    // MARK: - ValidForm and Design
    var isValidForm: Observable<Bool> {
        // Valid email
        // Password with one Capital letter , one small letter and Numbers
        return Observable.combineLatest(emailSubject, passwordSubject) { email, password in
            guard email != nil && password != nil else {
                return false
            }
            // Conditions:
            // Email is valid
            // Password is valid
            return self.emailValidator.validate(email ?? "") && self.passwordValidator.validate(password ?? "")
        }
    }
    
    func initFields(field: UITextField) {
        field.layer.cornerRadius = 5
        field.layer.borderColor = UIColor(rgb: 0xbdbdbd).cgColor
        field.layer.borderWidth = 0.5
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 13.0, height: 45.0))
        field.leftView = leftView
        field.leftViewMode = .always
    }
    
    // MARK: - Network call
    
    func requestLogin(withEmail email: String, withPassword password: String) {
        self.viewController?.showHUD()
        self.dataService?.requestLogin(withEmail: email, withPassword: password, completion: { (user, error) in
            if let error = error {
                self.error = error
                self.viewController?.hideHUD()
                return
            }
            self.error = nil
            self.viewController?.hideHUD()
            self.user = user
        })
    }
}
