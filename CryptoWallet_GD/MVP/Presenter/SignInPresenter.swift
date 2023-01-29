//
//  Presenter.swift
//  CryptoWallet_GD
//
//  Created by Grisha Diehl on 25.11.2022.
//

import Foundation

class SignInPresenter {
    
    private let model = AccessDataModel()
    var login = ""
    var password = ""
    
    weak var delegate: SignInPresenterDelegate?
    
    public func setViewDelegate(delegate: SignInPresenterDelegate) {
        self.delegate = delegate
    }
    
    public func signInTapped() {
        if login == model.login && password == model.password {
            UserDefaults.standard.set(true, forKey: "signIn")
            self.delegate?.askCoordinatorToPresentNextVC()
        } else {
            print("Wrong Data")
        }
    }
}


protocol SignInPresenterDelegate: AnyObject {
    func signIn()
    
    func passTextFieldDataToPresenter()
    
    func askCoordinatorToPresentNextVC()
}
