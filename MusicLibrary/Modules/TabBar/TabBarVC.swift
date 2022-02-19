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
        view.backgroundColor = .systemBackground
        tabBar.layer.backgroundColor = UIColor.systemBackground.cgColor
        setupVCs()
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: LibraryRouter().createModule(), title: NSLocalizedString("Library", comment: ""), image: UIImage(systemName: "folder.circle.fill")!),
            createNavController(for: FavoriteRouter().createModule(), title: NSLocalizedString("Favorite", comment: ""), image: UIImage(systemName: "bookmark.circle")!)
        ]
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
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .systemBackground
        
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
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }
}

extension TabBarVC: TabBarPresenterToViewProtocol {
    
}
