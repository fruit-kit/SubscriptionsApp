//
//  ForgotPasswordViewController.swift
//  Subscriptions
//
//  Created by Robert Kotrutsa on 27.11.2023.
//

import UIKit
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var resetPasswordButton: UIButton!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .backgroundColorVC
        
        setupTitleLabel()
        
        setupTextField()
        
        setupResetPasswordButton()
        
        setupDescriptionLabel()
    }
    
    // MARK: - Actions
    
    @IBAction func resetPasswordButtonPressed(_ sender: UIButton) {
        
        if let email = emailField.text, !email.isEmpty {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if error == nil {
                    self.dismiss(animated: true)
                }
            }
        } else {
            
            print("Please enter a valid email address")
        }
    }
    
    // MARK: - Private Methods
    
    private func setupDescriptionLabel() {
        
        descriptionLabel.text = "Password recovery instructions will be sent to your email".localized()
        descriptionLabel.font = .systemFont(ofSize: 18)
        descriptionLabel.textColor = .tabBarItemAccent
    }
    
    private func setupTitleLabel() {
        
        titleLabel.text = "Reset Password".localized()
        titleLabel.textColor = .tabBarItemAccent
        titleLabel.font = .systemFont(ofSize: 29)
    }
    
    private func setupTextField() {
        
        if let mainColor = UIColor(named: "mainColor") {
            emailField.attributedPlaceholder = NSAttributedString(
                string: "Email address".localized(),
                attributes: [NSAttributedString.Key.foregroundColor: mainColor]
            )
            emailField.borderStyle = .none
            emailField.textColor = .tabBarItemAccent
            emailField.backgroundColor = .backgroundColorVC
            emailField.layer.borderWidth = 2.0
            emailField.layer.borderColor = mainColor.cgColor
            emailField.layer.cornerRadius = 25.0
            emailField.clipsToBounds = true
            emailField.layer.shadowColor = UIColor.black.cgColor
            emailField.layer.shadowOpacity = 0.25
            emailField.layer.shadowOffset = CGSize(width: 0, height: 10)
            emailField.layer.shadowRadius = 10.0
            emailField.layer.masksToBounds = false
        }
    }
    
    private func setupResetPasswordButton() {
        
        if let mainColor = UIColor(named: "mainColor") {
            resetPasswordButton.setTitle("Reset".localized(), for: .normal)
            resetPasswordButton.tintColor = .backgroundColorVC
            resetPasswordButton.backgroundColor = mainColor
            resetPasswordButton.layer.cornerRadius = 5.0
        }
    }
    
}
