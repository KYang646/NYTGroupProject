//
//  SceneDelegate.swift
//  NYTimesGroupProj
//
//  Created by Kimball Yang on 10/18/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let tabBarVC = UITabBarController()
        
        let bestSellersVC = bestSellersViewController()
        let settingsVC = SettingsViewController()
        let favoritesVC = FavoritesViewController()
        let navigationVC = UINavigationController(rootViewController: bestSellersVC)
        
        tabBarVC.viewControllers = [navigationVC, settingsVC, favoritesVC]
        
        navigationVC.tabBarItem.title = "Best Sellers"
        favoritesVC.tabBarItem.title = "Favorites"
        settingsVC.tabBarItem.title = "Settings"
        
//        bestSellersVC.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
//        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
//        settingsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)
        //detailVC.tabBarItem = UITabBarItem(title: <#T##String?#>, image: <#T##UIImage?#>, tag: <#T##Int#>)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

