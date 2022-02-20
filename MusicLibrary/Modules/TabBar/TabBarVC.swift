//
//  TabBarVC.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.

import UIKit

class TabBarVC: UITabBarController {
    var presentor: TabBarViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        view.backgroundColor = Colors.background
        tabBar.layer.backgroundColor = Colors.background.cgColor
        setupVCs()
        tabBar()
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: LibraryRouter().createModule(), title: NSLocalizedString("Library", comment: ""), image: UIImage(systemName: "folder.circle.fill")!),
            createNavController(for: FavoriteRouter().createModule(), title: NSLocalizedString("Favorite", comment: ""), image: UIImage(systemName: "bookmark.circle")!)
        ]
    }
    
    func tabBar() {
        if #available(iOS 13.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor = Colors.background
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().tintColor = Colors.accent

            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
    }
    
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
//        rootViewController.navigationItem.title = title
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Colors.background
        
        appearance.titleTextAttributes = [.foregroundColor: Colors.title]
        appearance.largeTitleTextAttributes = [.foregroundColor: Colors.title]
        
        navController.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.defaultPrompt)
        navController.navigationBar.shadowImage = UIImage()
        
        navController.navigationBar.layer.borderColor = .none
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        
        return navController
    }

}

extension TabBarVC: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true;
    }
}

extension TabBarVC: TabBarPresenterToViewProtocol {
    
}
