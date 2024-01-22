//
//  AuthViewController.swift
//  Subscriptions
//
//  Created by Robert Kotrutsa on 26.11.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseDatabaseInternal
import GoogleSignIn
import FacebookLogin
import AuthenticationServices

class AuthViewController: UIViewController {
    
    // MARK: - Properties
    
    var signUp: Bool = true {
        willSet {
            if newValue {
                self.titleLabel.text = "Sign Up".localized()
                self.userNameField.isHidden = false
                self.enterButton.setTitle("Log In".localized(), for: .normal)
                descriptionLabel.text = "Already have an account?".localized()
            } else {
                self.titleLabel.text = "Log In".localized()
                self.userNameField.isHidden = true
                self.enterButton.setTitle("Sign Up".localized(), for: .normal)
                descriptionLabel.text = "Don't have an account yet?".localized()
            }
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    @IBOutlet weak var enterButton: UIButton!
    
    @IBOutlet weak var secondDescriptionLabel: UILabel!
    
    @IBOutlet weak var thirdDescriptionLabel: UILabel!
    
    @IBOutlet weak var googleAuthButton: UIButton!
    
    @IBOutlet weak var facebookAuthButton: UIButton!
    
    @IBOutlet weak var appleAuthButton: UIButton!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .backgroundColorVC
        
        setupTitleLabel()
        
        setupTextFields()
        
        setupDescriptionLabel()
        
        setupForgotPasswordButton()
        
        setupEnterButton()
        
        userNameField.delegate = self
        
        emailField.delegate = self
        
        passwordField.delegate = self
        
        setupSecondDescriptionLabel()
        
        setupThirdDescriptionLabel()
        
        setupGoogleAuthButton()
        
        setupFacebookAuthButton()
        
        setupAppleAuthButton()
    }
    
    // MARK: - View Appearance
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerKeyboardNotifications()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Actions
    
    @IBAction func forgotPasswordButtonPressed(_ sender: UIButton) {
        
        let forgotPasswordViewController = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: Bundle.main)
        
        self.present(forgotPasswordViewController, animated: true)
    }
    
    @IBAction func switchLogin(_ sender: UIButton) {
        
        signUp = !signUp
    }
    
    @IBAction func googleAuthButtonPressed(_ sender: UIButton) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else {
                print("Error with Google sign in: \(String(describing: error?.localizedDescription))")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                print("Failed to successfully get the user object and/or identification token")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { [unowned self] authResult, error in
                guard error == nil else {
                    print("Error with Firebase authentication: \(String(describing: error?.localizedDescription))")
                    return
                }
                
                if let uid = authResult?.user.uid {
                    let ref = Database.database().reference().child("users").child(uid)
                    
                    ref.child("registrationDate").observeSingleEvent(of: .value) { (snapshot) in
                        if !snapshot.exists() {
                            
                            let currentDate = Date()
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd MMMM yyyy"
                            let registrationDateString = dateFormatter.string(from: currentDate)
                            
                            ref.setValue(["userName": user.profile?.name, "email": user.profile?.email, "registrationDate": registrationDateString])
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func facebookAuthButtonPressed(_ sender: UIButton) {
        
        let loginManager = LoginManager()
        
        let permissions: [String] = ["public_profile", "email"]
        
        loginManager.logIn(permissions: permissions, from: self) { result, error in
            if let error = error {
                print("Auth error: \(error.localizedDescription)")
            } else if let result = result, !result.isCancelled {
                if let token = AccessToken.current {
                    let graphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "name, email"], tokenString: token.tokenString, version: nil, httpMethod: .get)
                    
                    graphRequest.start { _, result, error in
                        if let error = error {
                            print("Error executing Graph API request \(error.localizedDescription)")
                        } else if let result = result as? [String: Any] {
                            let name = result["name"] as? String ?? ""
                            let email = result["email"] as? String ?? ""
                            
                            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current?.tokenString ?? "")
                            
                            Auth.auth().signIn(with: credential) { authResult, error in
                                if let error = error {
                                    print("Firebase login error: \(error.localizedDescription)")
                                } else if let authResult = authResult {
                                    let ref = Database.database().reference().child("users").child(authResult.user.uid)
                                    
                                    ref.child("registrationDate").observeSingleEvent(of: .value) { (snapshot) in
                                        if !snapshot.exists() {
                                            
                                            let currentDate = Date()
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.dateFormat = "dd MMMM yyyy"
                                            let registrationDateString = dateFormatter.string(from: currentDate)
                                            
                                            ref.setValue(["userName": name, "email": email, "registrationDate": registrationDateString])
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func appleAuthButtonPressed(_ sender: UIButton) {
        
        print("appleAuthButtonPressed")
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // MARK: - Public Methods
    
    func showAlertError() {
        
        let alert = UIAlertController(title: "Error", message: "Fill in all the fields", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .cancel)
        
        alert.addAction(alertAction)
        
        self.present(alert, animated: true)
    }
    
    // MARK: - Private Methods
    
    private func setupTitleLabel() {
        
        titleLabel.text = "Sign Up"
        titleLabel.textColor = .tabBarItemAccent
        titleLabel.font = .systemFont(ofSize: 29)
    }
    
    private func setupTextFields() {
        
        if let mainColor = UIColor(named: "mainColor") {
            userNameField.attributedPlaceholder = NSAttributedString(
                string: "User name".localized(),
                attributes: [NSAttributedString.Key.foregroundColor: mainColor]
            )
        }
        userNameField.borderStyle = .none
        userNameField.textColor = .tabBarItemAccent
        userNameField.backgroundColor = .backgroundColorVC
        userNameField.layer.borderWidth = 2.0
        if let mainColor = UIColor(named: "mainColor") {
            userNameField.layer.borderColor = mainColor.cgColor
        }
        userNameField.layer.cornerRadius = 25.0
        userNameField.clipsToBounds = true
        userNameField.layer.shadowColor = UIColor.black.cgColor
        userNameField.layer.shadowOpacity = 0.25
        userNameField.layer.shadowOffset = CGSize(width: 0, height: 10)
        userNameField.layer.shadowRadius = 10.0
        userNameField.layer.masksToBounds = false
        
        if let mainColor = UIColor(named: "mainColor") {
            emailField.attributedPlaceholder = NSAttributedString(
                string: "Email address".localized(),
                attributes: [NSAttributedString.Key.foregroundColor: mainColor]
            )
        }
        
        emailField.borderStyle = .none
        emailField.textColor = .tabBarItemAccent
        emailField.backgroundColor = .backgroundColorVC
        emailField.layer.borderWidth = 2.0
        
        if let mainColor = UIColor(named: "mainColor") {
            emailField.layer.borderColor = mainColor.cgColor
        }
        
        emailField.layer.cornerRadius = 25.0
        emailField.clipsToBounds = true
        emailField.layer.shadowColor = UIColor.black.cgColor
        emailField.layer.shadowOpacity = 0.25
        emailField.layer.shadowOffset = CGSize(width: 0, height: 10)
        emailField.layer.shadowRadius = 10.0
        emailField.layer.masksToBounds = false
        
        if let mainColor = UIColor(named: "mainColor") {
            passwordField.attributedPlaceholder = NSAttributedString(
                string: "Password".localized(),
                attributes: [NSAttributedString.Key.foregroundColor: mainColor]
            )
        }
        
        passwordField.borderStyle = .none
        passwordField.textColor = .tabBarItemAccent
        passwordField.backgroundColor = .backgroundColorVC
        passwordField.layer.borderWidth = 2.0
        
        if let mainColor = UIColor(named: "mainColor") {
            passwordField.layer.borderColor = mainColor.cgColor
        }
        
        passwordField.layer.cornerRadius = 25.0
        passwordField.clipsToBounds = true
        passwordField.layer.shadowColor = UIColor.black.cgColor
        passwordField.layer.shadowOpacity = 0.25
        passwordField.layer.shadowOffset = CGSize(width: 0, height: 10)
        passwordField.layer.shadowRadius = 10.0
        passwordField.layer.masksToBounds = false
    }
    
    private func setupDescriptionLabel() {
        
        descriptionLabel.text = "Already have an account?".localized()
        descriptionLabel.font = .systemFont(ofSize: 18)
        descriptionLabel.textColor = .tabBarItemAccent
    }
    
    private func setupForgotPasswordButton() {
        
        forgotPasswordButton.setTitle("Reset Password".localized(), for: .normal)
        forgotPasswordButton.tintColor = .backgroundColorVC
        if let mainColor = UIColor(named: "mainColor") {
            forgotPasswordButton.backgroundColor = mainColor
        }
        forgotPasswordButton.layer.cornerRadius = 5.0
    }
    
    private func setupEnterButton() {
        
        
        enterButton.setTitle("Log In".localized(), for: .normal)
        enterButton.tintColor = .backgroundColorVC
        if let mainColor = UIColor(named: "mainColor") {
            enterButton.backgroundColor = mainColor
        }
        enterButton.layer.cornerRadius = 5.0
    }
    
    private func setupSecondDescriptionLabel() {
        
        secondDescriptionLabel.text = "Forgot your password?".localized()
        secondDescriptionLabel.font = .systemFont(ofSize: 18)
        secondDescriptionLabel.textColor = .tabBarItemAccent
    }
    
    private func setupThirdDescriptionLabel() {
        
        thirdDescriptionLabel.text = "Or continue with".localized()
        thirdDescriptionLabel.font = .systemFont(ofSize: 18)
        thirdDescriptionLabel.textColor = .tabBarItemAccent
    }
    
    private func setupGoogleAuthButton() {
        
        if let image = UIImage(named: "icon-google-auth") {
            googleAuthButton.setImage(image, for: .normal)
            googleAuthButton.setTitle("", for: .normal)
        } else {
            print("Image \"icon-google-auth\" not found!")
        }
    }
    
    private func setupFacebookAuthButton() {
        
        if let image = UIImage(named: "icon-facebook-auth") {
            facebookAuthButton.setImage(image, for: .normal)
            facebookAuthButton.setTitle("", for: .normal)
        } else {
            print("Image \"icon-facebook-auth\" not found!")
        }
    }
    
    private func setupAppleAuthButton() {
        
        if let image = UIImage(named: "icon-apple-auth") {
            appleAuthButton.setImage(image, for: .normal)
            appleAuthButton.setTitle("", for: .normal)
        } else {
            print("Image \"icon-apple-auth\" not found!")
        }
    }
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        
        guard let userInfo: NSDictionary = notification.userInfo as? NSDictionary else { return }
        guard let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc
    private func keyboardWillHide(notification: NSNotification) {
        
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    @objc
    private func endEditing() {
        
        view.endEditing(true)
    }
    
}

// MARK: - Extensions

// MARK: - UITextFieldDelegate

extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let userName = userNameField.text, !userName.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            showAlertError()
            return false
        }
        
        if signUp {
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error creating user: \(error.localizedDescription)")
                    self.showAlertError()
                } else if let result = result {
                    let ref = Database.database().reference().child("users").child(result.user.uid)
                    
                    ref.child("registrationDate").observeSingleEvent(of: .value) { (snapshot) in
                        if !snapshot.exists() {
                            let currentDate = Date()
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd MMMM yyyy"
                            let registrationDateString = dateFormatter.string(from: currentDate)
                            
                            ref.setValue(["userName": userName, "email": email, "registrationDate": registrationDateString])
                        }
                    }
                }
            }
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
                if let error = error {
                    print("Login failed: \(error.localizedDescription)")
                }
            }
        }
        return true
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding

extension AuthViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        
        return self.view.window!
    }
}

// MARK: - ASAuthorizationControllerDelegate

extension AuthViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let userIdentifier = appleIDCredential.user
            
            print(userIdentifier)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        print("Error: \(error.localizedDescription)")
    }
}
