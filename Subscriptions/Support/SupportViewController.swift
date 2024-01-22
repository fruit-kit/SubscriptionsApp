//
//  SupportViewController.swift
//  Subscriptions
//
//  Created by Robert Kotrutsa on 14.12.2023.
//

import UIKit

class SupportViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var emailTitle: UILabel!
    
    @IBOutlet weak var telegramView: UIView!
    
    @IBOutlet weak var telegramTitle: UILabel!
    
    @IBOutlet weak var instagramView: UIView!
    
    @IBOutlet weak var instagramTitle: UILabel!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitle()
        
        setupDescription()
        
        setupEmailView()
    }
    
    // MARK: - Actions
    
    @IBAction func emailButtonPressed(_ sender: UIButton) {
        
        let email = "your.subscriptions.app@gmail.com"
        
        if let mailURL = URL(string: "mailto:\(email)") {
            
            if UIApplication.shared.canOpenURL(mailURL) {
                
                UIApplication.shared.open(mailURL, options: [:], completionHandler: nil)
            } else {
                
                if let webMailURL = URL(string: "https://mail.google.com/mail/?view=cm&fs=1&to=\(email)") {
                    
                    UIApplication.shared.open(webMailURL, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func setupTitle() {
        
        title = "Support".localized()
    }
    
    private func setupDescription() {
        
        descriptionLabel.text = "If you notice any problem \nplease let us know by email \n👇".localized()
        descriptionLabel.textColor = .tabBarItemAccent
        descriptionLabel.font = UIFont.systemFont(ofSize: 18)
    }
    
    private func setupEmailView() {
        
        setupEmailTitle()
        
        if let mainColor = UIColor(named: "mainColor") {
            
            emailView.backgroundColor = mainColor
        }
        
        emailView.layer.cornerRadius = 20
        emailView.layer.shadowColor = UIColor.black.cgColor
        emailView.layer.shadowOpacity = 0.25
        emailView.layer.shadowOffset = CGSize(width: 0, height: 10)
        emailView.layer.shadowRadius = 10.0
    }
    
    private func setupEmailTitle() {
        
        emailTitle.text = "Email".localized()
        emailTitle.textColor = .backgroundColorVC
        emailTitle.font = .systemFont(ofSize: 20)
    }
    
}
