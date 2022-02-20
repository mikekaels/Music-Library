//
//  Extension + UIViewController.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 21/02/22.
//

import UIKit

extension UIViewController: Alertable {
    func navigationBarAppearance() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = Colors.title
            navigationController?.navigationBar.standardAppearance = appearance;
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            UISearchBar.appearance().tintColor = UIColor.white
        }
    }
}

extension UIViewController {
    open func noInternetConnection(_ isNoInternetConnection: Bool,
                                   completion: @escaping() -> Void) {
        if isNoInternetConnection {
            showAlert(title: "Whoops!",
                      message: "Please check your network connection and try again.",
                      actionTitle: "Try Again", completion: completion)
        }
    }
}
