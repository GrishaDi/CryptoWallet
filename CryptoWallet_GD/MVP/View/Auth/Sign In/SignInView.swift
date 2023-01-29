//
//  LoginView.swift
//  CryptoWallet_GD
//
//  Created by Grisha Diehl on 23.11.2022.
//

import UIKit

class SignInView: UIView {

    let loginField: UITextField = {
        let field = UITextField()
        let blackPlaceholderText = NSAttributedString(string: " Login",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        field.attributedPlaceholder = blackPlaceholderText
        field.textColor = .black
        field.keyboardType = .alphabet
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.leftViewMode = .always
        field.backgroundColor = .systemYellow
        field.layer.borderWidth = 1.5
        field.layer.borderColor = UIColor.systemBlue.cgColor
        field.layer.cornerRadius = 6
        field.layer.masksToBounds = true
        
        return field
    }()

    let passwordField: UITextField = {
        let field = UITextField()
        let blackPlaceholderText = NSAttributedString(string: " Password",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        field.attributedPlaceholder = blackPlaceholderText
        field.textColor = .black
        field.keyboardType = .numbersAndPunctuation
        field.leftViewMode = .always
        field.placeholder = " Password"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.isSecureTextEntry = true
        field.backgroundColor = .systemYellow
        field.layer.borderWidth = 1.5
        field.layer.borderColor = UIColor.systemBlue.cgColor
        field.layer.cornerRadius = 6
        field.layer.masksToBounds = true
        
        return field
    }()

    let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemYellow
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 6
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(loginField)
        addSubview(passwordField)
        addSubview(signInButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
