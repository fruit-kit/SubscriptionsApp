//
//  SceneDelegate.swift
//  Subscriptions
//
//  Created by Robert Kotrutsa on 01.11.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FacebookCore
import FirebaseFirestore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Properties
    
    var window: UIWindow?
    
    // MARK: - Scene Lifecycle
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        
        let authViewController = AuthViewController(nibName: "AuthViewController", bundle: nil)
        self.window?.rootViewController = authViewController
        
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user {
                
                let rootViewController = CustomTabBarController(with: user)
                self.window?.rootViewController = rootViewController
            }
            
            self.window?.makeKeyAndVisible()
        }
    }
    
    // MARK: - Logout
    
    func logout() {
        
        let authViewController = AuthViewController(nibName: "AuthViewController", bundle: nil)
        self.window?.rootViewController = authViewController
    }
    
    func sceneDidDisconnect(_ scene: UIScene) { }
    
    func sceneDidBecomeActive(_ scene: UIScene) { }
    
    func sceneWillResignActive(_ scene: UIScene) { }
    
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    func sceneDidEnterBackground(_ scene: UIScene) { }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
        guard let url = URLContexts.first?.url else {
            return
        }
        
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
    }
    
}
