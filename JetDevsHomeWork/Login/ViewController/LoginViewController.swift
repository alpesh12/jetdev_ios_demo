//
//  LoginViewController.swift
//  JetDevsHomeWork
//
//  Created by Avruti on 08/12/22.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton! { didSet {
        loginButton.backgroundColor = loginButton.isEnabled ? UIColor(rgb: 0x28518D) : UIColor(rgb: 0xBDBDBD)
    }}
    
    // MARK: - Injection
    
    let viewModel = LoginViewModel(dataService: LoginAPIService())
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewController = self
        setupForm()
        
    }
    
    // MARK: - View life cycle
    
    @IBAction func closeButtonTap(_ sender: Any) {
        AppDelegate.sharedDelegate().gotoTabScreen()
    }
    
    // MARK: - Form Validation Setup
    
    func setupForm() {
        
        viewModel.showAlertClosure = {
            if let error = self.viewModel.error {
                self.showAlert(message: error)
            }
        }
        
        viewModel.didFinishFetch = {
            if let user = self.viewModel.user {
                UserDefaults.standard.set(try? JSONEncoder().encode(user), forKey: "userDetails")
                UserDefaults.standard.synchronize()
                AppDelegate.sharedDelegate().gotoTabScreen()
            }
        }
        
        viewModel.initFields(field: emailTextField)
        viewModel.initFields(field: passwordTextField)
        
        emailTextField.rx.text.bind(to: viewModel.emailSubject).disposed(by: disposeBag)
        passwordTextField.rx.text.bind(to: viewModel.passwordSubject).disposed(by: disposeBag)
        
        viewModel.isValidForm.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        viewModel.isValidForm
            .subscribe(onNext: { isValid in
                        if(isValid) {
                            self.loginButton.backgroundColor = UIColor(rgb: 0x28518D)
                        } else {
                            self.loginButton.backgroundColor = UIColor(rgb: 0xBDBDBD)
                        }
          })
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
                   .subscribe(onNext: { [weak self] _ in self?.loginApiCall() })
                   .disposed(by: disposeBag)
    }
    
    // MARK: - Submit Clicked
    
    func loginApiCall() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            self.showAlert(message: "Email and Password can't be empty")
            return
        }
        viewModel.requestLogin(withEmail: email, withPassword: password)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(
            title: "Login",
            message: message,
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
