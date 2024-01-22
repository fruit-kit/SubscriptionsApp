//
//  PersonViewController.swift
//  Subscriptions
//
//  Created by Robert Kotrutsa on 01.11.2023.
//

import UIKit
import FirebaseAuth
import FirebaseDatabaseInternal

class PersonViewController: UIViewController, WithUser {
    
    var user: User?
    
    // MARK: - Outlets
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var yearsOfRegistrationView: UIView!
    
    @IBOutlet weak var yearsOfRegistration: UILabel!
    
    @IBOutlet weak var logOutButton: UIButton!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .backgroundColorVC
        
        setupTitle()
        
        setupProfileView()
        
        setupStackProfileInformation()
        
        setupLogOutButton()
        
        loadUserInfo()
    }
    
    // MARK: - Actions
    
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Log out", message: "Are you sure you want to log out?", preferredStyle: .alert)
        
        let alertActionSuccess = UIAlertAction(title: "Ok", style: .default) { _ in
            
            do {
                self.clearUserDefaults()
                try Auth.auth().signOut()
                guard let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate else { return }
                sceneDelegate.logout()
            } catch {
                print(error)
            }
        }
        
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(alertActionSuccess)
        alertController.addAction(alertActionCancel)
        
        self.present(alertController, animated: true)
    }
    
    // MARK: - Private Methods
    
    private func clearUserDefaults() {
        
        UserDefaults.standard.removeObject(forKey: "subscriptions")
        UserDefaults.standard.synchronize()
    }
    
    private func getUserRegistrationDate(forUserID userID: String, completion: @escaping (String?) -> Void) {
        
        if let savedRegistrationDate = UserDefaults.standard.string(forKey: "registrationDate_\(userID)") {
            
            self.yearsOfRegistration.text = "\(savedRegistrationDate)"
            completion(savedRegistrationDate)
        } else {
            
            let userRef = Database.database().reference().child("users").child(userID)
            userRef.observeSingleEvent(of: .value, with: { snapshot in
                
                if let userData = snapshot.value as? [String: Any],
                   let registrationDate = userData["registrationDate"] as? String {
                    
                    UserDefaults.standard.set(registrationDate, forKey: "registrationDate_\(userID)")
                    self.yearsOfRegistration.text = "\(registrationDate)"
                    completion(registrationDate)
                } else {
                    
                    completion(nil)
                }
            })
        }
    }
    
    private func loadUserInfo() {
        
        self.profileName.text = user?.displayName ?? "User name N/A"
        self.email.text = user?.email ?? "Mail N/A"
        
        if let photoURL = user?.photoURL {
            self.profileImage.load(url: photoURL)
            self.profileImage.layer.borderColor = UIColor.backgroundColorVC.cgColor
            self.profileImage.layer.borderWidth = 4
        }
        
        if let userID = user?.uid {
            self.getUserRegistrationDate(forUserID: userID) { registrationDate in
                if let registrationDate = registrationDate {
                    print("User registration date: \(registrationDate)")
                } else {
                    print("Registration date not found or an error occurred")
                }
            }
        } else {
            print("User is nil, unable to fetch registration date")
        }
    }
    
    private func setupLogOutButton() {
        
        let logOutImg = UIImage(named: "logout-icon")
        
        logOutButton.setImage(logOutImg, for: .normal)
    }
    
    private func setupTitle() {
        
        title = DefaultValues.personalInfo
    }
    
    private func setupProfileView() {
        
        setupProfileImage()
        
        setupProfileName()
        
        if let mainColor = UIColor(named: "mainColor") {
            profileView.backgroundColor = mainColor
        }
        profileView.layer.cornerRadius = 20
        profileView.layer.shadowColor = UIColor.black.cgColor
        profileView.layer.shadowOpacity = 0.25
        profileView.layer.shadowOffset = CGSize(width: 0, height: 10)
        profileView.layer.shadowRadius = 10.0
    }
    
    private func setupProfileImage() {
        
        profileImage.layer.cornerRadius = 40
        profileImage.image = UIImage(named: "profile-icon")
    }
    
    private func setupProfileName() {
        
        profileName.text = "User name N/A"
        profileName.textColor = .backgroundColorVC
        profileName.font = .systemFont(ofSize: 22)
    }
    
    private func setupStackProfileInformation() {
        
        setupEmailView()
        
        setupYearsOfRegistrationView()
    }
    
    private func setupEmailView() {
        
        setupEmail()
        
        if let mainColor = UIColor(named: "mainColor") {
            emailView.backgroundColor = mainColor
        }
        emailView.layer.cornerRadius = 20
        emailView.layer.shadowColor = UIColor.black.cgColor
        emailView.layer.shadowOpacity = 0.25
        emailView.layer.shadowOffset = CGSize(width: 0, height: 10)
        emailView.layer.shadowRadius = 10.0
    }
    
    private func setupEmail() {
        
        email.text = "Mail N/A"
        email.textColor = .backgroundColorVC
        email.font = .systemFont(ofSize: 20)
    }
    
    private func setupYearsOfRegistrationView() {
        
        setupYearsOfRegistration()
        
        if let mainColor = UIColor(named: "mainColor") {
            yearsOfRegistrationView.backgroundColor = mainColor
        }
        yearsOfRegistrationView.layer.cornerRadius = 20
        yearsOfRegistrationView.layer.shadowColor = UIColor.black.cgColor
        yearsOfRegistrationView.layer.shadowOpacity = 0.25
        yearsOfRegistrationView.layer.shadowOffset = CGSize(width: 0, height: 10)
        yearsOfRegistrationView.layer.shadowRadius = 10.0
    }
    
    private func setupYearsOfRegistration() {
        
        yearsOfRegistration.text = "Registered since: N/A"
        yearsOfRegistration.textColor = .backgroundColorVC
        yearsOfRegistration.font = .systemFont(ofSize: 20)
    }
    
}

// MARK: - Extension

extension UIImageView {
    
    func load(url: URL) {
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            if let data = data, let image = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    
                    self?.image = image
                }
            }
        }.resume()
    }
}
