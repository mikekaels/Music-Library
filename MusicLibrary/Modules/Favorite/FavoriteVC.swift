//
//  FavoriteVC.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.

import UIKit

class FavoriteVC: UIViewController {
    
    var presentor: FavoriteViewToPresenterProtocol?
    public var delegate: FavoriteDelegate?
    
    lazy var table = MusicListTableViewController(items: [], configure: { (cell: SongTableViewCell, item: FavoriteSongs) in
        cell.lblSongTitle.text = item.songTitle
        cell.lblSinger.text = item.singer
        cell.state = item.saved == 1 ? .saved : .add
        cell.id = item.id
        cell.delegate = self
    }) { (item) in

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite"
        setupUI()
        updateTableData()
        receiveNC()
    }
    
    func removeFromFavorites(id: NSNumber) {
        presentor?.removeFavorite(id: id)
    }
    
    func receiveNC() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableData), name: NSNotification.Name("update.table.data.favorite"), object: nil)
    }
    
    func broadcastNC() {
        NotificationCenter.default.post(name: NSNotification.Name("update.table.data.library"),object: nil)
    }
    
    @objc func updateTableData() {
        presentor?.fetchFavorites()
    }
}

extension FavoriteVC: FavoritePresenterToViewProtocol {
    func didRemoveFromFavorite() {
        updateTableData()
    }
    
    
    func didFetchFavorite(favorites: [FavoriteSongs]) {
        DispatchQueue.main.async { [weak self] in
            self?.table.items = favorites
        }
    }
}

extension FavoriteVC: SongCellDelegate {

    func addToFavorites(id: NSNumber, songTitle: String, singer: String) {

    }
    
    func removeFromFavorite(id: NSNumber) {
        presentor?.removeFavorite(id: id)
        broadcastNC()
        self.updateTableData()
    }
}

extension FavoriteVC {
    func setupUI() {
        view.backgroundColor = Colors.background
        addChild(table)
        view.addSubview(table.view)
        table.didMove(toParent: self)
        
        table.view.snp.makeConstraints { make in
            make.top.trailing.bottom.leading.equalTo(view)
        }
    }
}

