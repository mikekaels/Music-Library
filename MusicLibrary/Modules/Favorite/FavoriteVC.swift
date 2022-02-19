//
//  FavoriteVC.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.

import UIKit

class FavoriteVC: UIViewController {
    var presentor: FavoriteViewToPresenterProtocol?
    public var delegate: FavoriteDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite"
        view.backgroundColor = .systemPurple
        // Do any additional setup after loading the view.
    }

}

extension FavoriteVC: FavoritePresenterToViewProtocol {
    
}
