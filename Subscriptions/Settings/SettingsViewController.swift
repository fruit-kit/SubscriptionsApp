//
//  SettingsViewController.swift
//  Subscriptions
//
//  Created by Robert Kotrutsa on 01.11.2023.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController, WithUser {
    
    // MARK: - Properties
    
    var user: User?
    
    private let router: SettingsRouter = Router.shared
    
    // MARK: - Outlets
    
    @IBOutlet weak var languageView: UIView!
    
    @IBOutlet weak var languageTitle: UILabel!
    
    @IBOutlet weak var languageSegment: UISegmentedControl!
    
    @IBOutlet weak var supprotView: UIView!
    
    @IBOutlet weak var supportTitle: UILabel!
    
    @IBOutlet weak var socialView: UIView!
    
    @IBOutlet weak var socialTitle: UILabel!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .backgroundColorVC
        
        setupTitle()
        
        setupLanguageView()
        
        if let savedSegmentIndex = UserDefaults.standard.value(forKey: "SelectedSegmentIndex") as? Int {
            
            languageSegment.selectedSegmentIndex = savedSegmentIndex
        }
        
        setupSupportView()
        
        setupSocialView()
        
        setupBackButton()
    }
    
    // MARK: - Actions
    
    @IBAction func socialButtonPressed(_ sender: UIButton) {
        
        router.openSocialVC(from: self, animated: true)
    }
    
    @IBAction func supportButtonPressed(_ sender: UIButton) {
        
        router.openSupportVC(from: self, animated: true)
    }
    
    @IBAction func languageSegmentAction(_ sender: UISegmentedControl) {
        
        let selectedSegmentIndex = sender.selectedSegmentIndex
        
        let selectedLanguageCode = determineLanguageCode(forSegmentIndex: selectedSegmentIndex)
        
        UserDefaults.standard.set(selectedSegmentIndex, forKey: "SelectedSegmentIndex")
        
        let currentLanguageCode = UserDefaults.standard.stringArray(forKey: "AppleLanguages")?.first ?? "en"
        if currentLanguageCode != selectedLanguageCode {
            
            UserDefaults.standard.set([selectedLanguageCode], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            
            alert(completion: {
                
                exit(EXIT_SUCCESS)
            })
        }
    }
    
    // MARK: - Public Methods
    
    func alert(completion: @escaping () -> Void) {
        
        let alertController = UIAlertController(title: "", message: "To change the language you need to reload the application. Reload?".localized(), preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .default) { _ in
            completion()
        }
        
        let alertCancel = UIAlertAction(title: "Cancel".localized(), style: .cancel)
        
        alertController.addAction(alertAction)
        alertController.addAction(alertCancel)
        
        self.present(alertController, animated: true)
    }
    
    func determineLanguageCode(forSegmentIndex index: Int) -> String {
        
        switch index {
            
        case 0:
            return "en"
        case 1:
            return "ru"
        default:
            return "en"
        }
    }
    
    // MARK: - Private Methods
    
    private func setupBackButton() {
        
        let backButton = UIBarButtonItem()
        backButton.tintColor = .tabBarItemAccent
        navigationItem.backBarButtonItem = backButton
    }
    
    private func setupTitle() {
        
        title = DefaultValues.settingsTitle
    }
    
    private func setupLanguageView() {
        
        setupLanguageTitle()
        setupLanguageSegment()
        
        if let mainColor = UIColor(named: "mainColor") {
            
            languageView.backgroundColor = mainColor
        }
        
        languageView.layer.cornerRadius = 20
        languageView.layer.shadowColor = UIColor.black.cgColor
        languageView.layer.shadowOpacity = 0.25
        languageView.layer.shadowOffset = CGSize(width: 0, height: 10)
        languageView.layer.shadowRadius = 10.0
    }
    
    private func setupLanguageTitle() {
        
        languageTitle.text = "Lenguage".localized()
        languageTitle.textColor = .backgroundColorVC
        languageTitle.font = .systemFont(ofSize: 20)
    }
    
    private func setupLanguageSegment() {
        
        languageSegment.setTitle("EN".localized(), forSegmentAt: 0)
        languageSegment.setTitle("RU".localized(), forSegmentAt: 1)
        
        if let mainColor = UIColor(named: "mainColor") {
            
            languageSegment.selectedSegmentTintColor = mainColor
            
            languageSegment.backgroundColor = .backgroundColorVC
            
            let selectedAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.backgroundColorVC
            ]
            languageSegment.setTitleTextAttributes(selectedAttributes, for: .selected)
            
            let normalAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: mainColor
            ]
            languageSegment.setTitleTextAttributes(normalAttributes, for: .normal)
        }
    }
    
    private func setupSupportView() {
        
        setupSupportTitle()
        
        if let mainColor = UIColor(named: "mainColor") {
            
            supprotView.backgroundColor = mainColor
        }
        
        supprotView.layer.cornerRadius = 20
        supprotView.layer.shadowColor = UIColor.black.cgColor
        supprotView.layer.shadowOpacity = 0.25
        supprotView.layer.shadowOffset = CGSize(width: 0, height: 10)
        supprotView.layer.shadowRadius = 10.0
    }
    
    private func setupSupportTitle() {
        
        supportTitle.text = "Support".localized()
        supportTitle.textColor = .backgroundColorVC
        supportTitle.font = .systemFont(ofSize: 20)
    }
    
    private func setupSocialView() {
        
        setupSocialTitle()
        
        if let mainColor = UIColor(named: "mainColor") {
            
            socialView.backgroundColor = mainColor
        }
        
        socialView.layer.cornerRadius = 20
        socialView.layer.shadowColor = UIColor.black.cgColor
        socialView.layer.shadowOpacity = 0.25
        socialView.layer.shadowOffset = CGSize(width: 0, height: 10)
        socialView.layer.shadowRadius = 10.0
    }
    
    private func setupSocialTitle() {
        
        socialTitle.text = "Social".localized()
        socialTitle.textColor = .backgroundColorVC
        socialTitle.font = .systemFont(ofSize: 20)
    }
    
}


