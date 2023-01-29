//
//  ViewController.swift
//  CryptoWallet_GD
//
//  Created by Grisha Diehl on 23.11.2022.
//

import UIKit

class SignInViewController: UIViewController, Coordinating, SignInPresenterDelegate {

    private let container = SignInView()
    private let presenter = SignInPresenter()
    var coordinator: Coordinator?
    
    private var signInButtonBottomConstraintKeyboardOn: NSLayoutConstraint? = nil
    private var signInButtonBottomConstraintKeyboardOff: NSLayoutConstraint? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(container)
        view.backgroundColor = .black
        container.backgroundColor = .black
        
        presenter.setViewDelegate(delegate: self)
        presenter.delegate = self
        
        setupButtons()
        setupConstraints()
        
        container.loginField.setLeftPaddingPoints(5)
        container.passwordField.setLeftPaddingPoints(5)
        
        title = "Sign In"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemYellow
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemYellow]
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

    private func setupButtons() {
        container.signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        let signInScreenElements = [container, container.loginField, container.passwordField, container.signInButton]
        for element in signInScreenElements {
            element.translatesAutoresizingMaskIntoConstraints = false
        }
        let constraints = [
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            container.loginField.topAnchor.constraint(equalTo: container.topAnchor, constant: 120),
            container.loginField.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.45),
            container.loginField.heightAnchor.constraint(equalToConstant: 36),
            container.loginField.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            
            container.passwordField.topAnchor.constraint(equalTo: container.loginField.bottomAnchor, constant: 14),
            container.passwordField.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.45),
            container.passwordField.heightAnchor.constraint(equalToConstant: 36),
            container.passwordField.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            
            container.signInButton.topAnchor.constraint(equalTo: container.passwordField.bottomAnchor, constant: 28),
            container.signInButton.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.35),
            container.signInButton.heightAnchor.constraint(equalToConstant: 36),
            container.signInButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func signIn() {
        passTextFieldDataToPresenter()
        presenter.signInTapped()
    }
    
    func passTextFieldDataToPresenter() {
        presenter.login = container.loginField.text ?? ""
        presenter.password = container.passwordField.text ?? ""
    }
    
    func askCoordinatorToPresentNextVC() {
        coordinator?.eventOccurred(with: .signInButtonTapped, coin: nil)
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
