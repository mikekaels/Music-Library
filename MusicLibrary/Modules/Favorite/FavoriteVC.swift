//
//  FavoriteVC.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.

import UIKit

class FavoriteVC: UIViewController {
    var presentor: FavoriteViewToPresenterProtocol?
    public var delegate: FavoriteDelegate?
    
    lazy var table = MusicListTableViewController(items: [], configure: { (cell: SongTableViewCell, item: TrackList) in
        cell.lblSongTitle.text = item.track?.trackName
        cell.lblSinger.text = item.track?.artistName
    }) { (item) in
        print(item!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite"
        view.backgroundColor = .systemPurple
        // Do any additional setup after loading the view.
        setupUI()
    }

}

extension FavoriteVC: FavoritePresenterToViewProtocol {
    
}

extension FavoriteVC {
    func setupUI() {
        addChild(table)
        view.addSubview(table.view)
        table.didMove(toParent: self)
        
        table.view.snp.makeConstraints { make in
            make.top.trailing.bottom.leading.equalTo(view)
        }
    }
}
