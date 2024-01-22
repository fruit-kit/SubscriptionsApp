//
//  CustomTabBarController.swift
//  Subscriptions
//
//  Created by Robert Kotrutsa on 01.11.2023.
//

import UIKit
import FirebaseAuth

class CustomTabBarController: UITabBarController {
    
    var user: User?
    
    init(with user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
        
        generateTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarAppearance()
    }
    
    // MARK: - Methods
    
    func setTabBarAppearance() {
        
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: positionOnX,
                y: tabBar.bounds.minY - positionOnY,
                width: width,
                height: height
            ),
            cornerRadius: height / 2
        )
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 4
        tabBar.itemPositioning = .centered
        
        if let mainColor = UIColor(named: "mainColor") {
            roundLayer.fillColor = mainColor.cgColor
            
            roundLayer.strokeColor = UIColor.tabBarItemAccent.cgColor
            roundLayer.lineWidth = 2.0
            
            tabBar.tintColor = .tabBarItemAccent
            tabBar.unselectedItemTintColor = .tabBarItemAccent
            
            let appearance = UITabBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .clear
            appearance.selectionIndicatorTintColor = .tabBarItemAccent
            
            
            appearance.stackedLayoutAppearance.normal.iconColor = .backgroundColorVC
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: UIColor.backgroundColorVC,
                .font: UIFont.systemFont(ofSize: 12)
            ]
            
            appearance.stackedLayoutAppearance.selected.iconColor = .tabBarItemAccent
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: UIColor.tabBarItemAccent,
                .font: UIFont.boldSystemFont(ofSize: 12)
            ]
            
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
            
            tabBar.layer.shadowColor = UIColor.black.cgColor
            tabBar.layer.shadowOpacity = 0.25
            tabBar.layer.shadowOffset = CGSize(width: 0, height: 10)
            tabBar.layer.shadowRadius = 8.0
        }
    }
    
    // MARK: - Private Methods
    
    private func generateTabBar() {
        
        viewControllers = [
            generateVC(
                viewController: HomeViewController(),
                title: "Home",
                image: UIImage(systemName: "house.fill")),
            generateVC(
                viewController: PersonViewController(),
                title: "Personal info".localized(),
                image: UIImage(systemName: "person.fill")),
            generateVC(
                viewController: SettingsViewController(),
                title: "Settings".localized(),
                image: UIImage(systemName: "gearshape.fill"))
        ]
    }
    
    private func generateVC(viewController: WithUser, title: String, image: UIImage?) -> UINavigationController {
        
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        viewController.user = user
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let fontSize: CGFloat = 29
        let font = UIFont.systemFont(ofSize: fontSize)
        let textColor = UIColor.colorTitleVC
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: textColor
        ]
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = titleAttributes
        
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        
        return navigationController
    }
    
}
