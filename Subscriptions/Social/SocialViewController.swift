//
//  SocialViewController.swift
//  Subscriptions
//
//  Created by Robert Kotrutsa on 14.12.2023.
//

import UIKit

class SocialViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var telegramView: UIView!
    
    @IBOutlet weak var telegramTitle: UILabel!
    
    @IBOutlet weak var instagramView: UIView!
    
    @IBOutlet weak var instagramTitle: UILabel!
    
    @IBOutlet weak var facebookView: UIView!
    
    @IBOutlet weak var facebookTitile: UILabel!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSocialTitle()
        
        setupTelegramView()
        
        setupInstagramView()
        
        setupFacebookView()
    }
    
    // MARK: - Actions
    
    @IBAction func telegramButtonPressed(_ sender: UIButton) {
        
        let telegramUsername = "fruitkit"
        
        if let telegramURL = URL(string: "tg://resolve?domain=\(telegramUsername)") {
            
            if UIApplication.shared.canOpenURL(telegramURL) {
                
                UIApplication.shared.open(telegramURL, options: [:], completionHandler: nil)
            } else {
                
                if let telegramWebURL = URL(string: "https://t.me/\(telegramUsername)") {
                    
                    UIApplication.shared.open(telegramWebURL, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    @IBAction func instagramButtonPressed(_ sender: UIButton) {
        
        let instagramUsername = "fruit.kit"
        
        if let instagramURL = URL(string: "instagram://user?username=\(instagramUsername)") {
            
            if UIApplication.shared.canOpenURL(instagramURL) {
                
                UIApplication.shared.open(instagramURL, options: [:], completionHandler: nil)
            } else {
                
                if let instagramWebURL = URL(string: "https://www.instagram.com/\(instagramUsername)") {
                    
                    UIApplication.shared.open(instagramWebURL, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    @IBAction func facebookButtonPressed(_ sender: UIButton) {
        
        let facebookUsername = "fruitkit"
        
        if let facebookURL = URL(string: "fb://profile/\(facebookUsername)") {
            
            if UIApplication.shared.canOpenURL(facebookURL) {
                
                UIApplication.shared.open(facebookURL, options: [:], completionHandler: nil)
            } else {
                
                if let facebookWebURL = URL(string: "https://www.facebook.com/\(facebookUsername)") {
                    
                    UIApplication.shared.open(facebookWebURL, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func setupSocialTitle() {
        
        title = "Social".localized()
    }
    
    private func setupTelegramView() {
        
        setupTelegramTitle()
        
        if let mainColor = UIColor(named: "mainColor") {
            
            telegramView.backgroundColor = mainColor
        }
        
        telegramView.layer.cornerRadius = 20
        telegramView.layer.shadowColor = UIColor.black.cgColor
        telegramView.layer.shadowOpacity = 0.25
        telegramView.layer.shadowOffset = CGSize(width: 0, height: 10)
        telegramView.layer.shadowRadius = 10.0
    }
    
    private func setupTelegramTitle() {
        
        telegramTitle.text = "telegram".localized()
        telegramTitle.textColor = .backgroundColorVC
        telegramTitle.font = .systemFont(ofSize: 20)
    }
    
    private func setupInstagramView() {
        
        setupInstagramTitle()
        
        if let mainColor = UIColor(named: "mainColor") {
            
            instagramView.backgroundColor = mainColor
        }
        
        instagramView.layer.cornerRadius = 20
        instagramView.layer.shadowColor = UIColor.black.cgColor
        instagramView.layer.shadowOpacity = 0.25
        instagramView.layer.shadowOffset = CGSize(width: 0, height: 10)
        instagramView.layer.shadowRadius = 10.0
    }
    
    private func setupInstagramTitle() {
        
        instagramTitle.text = "instagram".localized()
        instagramTitle.textColor = .backgroundColorVC
        instagramTitle.font = .systemFont(ofSize: 20)
    }
    
    private func setupFacebookView() {
        
        setupFacebookTitle()
        
        if let mainColor = UIColor(named: "mainColor") {
            
            facebookView.backgroundColor = mainColor
        }
        
        facebookView.layer.cornerRadius = 20
        facebookView.layer.shadowColor = UIColor.black.cgColor
        facebookView.layer.shadowOpacity = 0.25
        facebookView.layer.shadowOffset = CGSize(width: 0, height: 10)
        facebookView.layer.shadowRadius = 10.0
    }
    
    private func setupFacebookTitle() {
        
        facebookTitile.text = "facebook".localized()
        facebookTitile.textColor = .backgroundColorVC
        facebookTitile.font = .systemFont(ofSize: 20)
    }
    
}
