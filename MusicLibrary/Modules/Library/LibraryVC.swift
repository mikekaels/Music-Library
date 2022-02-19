//
//  LibraryVC.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.

import UIKit
import SnapKit

class LibraryVC: UIViewController {
    var presentor: LibraryViewToPresenterProtocol?
    public var delegate: LibraryDelegate?
    var page = 1
    var pageSize = 10
    
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Find Songs..."
        sc.searchBar.delegate = self
        sc.searchBar.searchTextField.textColor = UIColor.white
        return sc
    }()
    
    lazy var table = MusicListTableViewController(items: [], configure: { (cell: SongTableViewCell, item: TrackList) in
        cell.lblSongTitle.text = item.track?.trackName
        cell.lblSinger.text = item.track?.artistName
    }) { (item) in
        print(item!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Library"
        setupUI()
        presentor?.fetchChart(page: self.page, pageSize: self.pageSize)
    }

}

extension LibraryVC: LibraryPresenterToViewProtocol {
    func didSuccesFetchChart(music: [TrackList]) {
        DispatchQueue.main.async { [weak self] in
            self?.table.items.append(contentsOf: music)
        }
    }
    
    func didFailFetchChart(error: CustomError) {
        
    }
    
    
}



//MARK: - UISEARCHBAR DELEGATE
extension LibraryVC: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    
    //MARK: - SEARCH CONTROL
    private func setupNavigationBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension LibraryVC {
    func setupUI() {
        setupNavigationBar()
        
        addChild(table)
        view.backgroundColor = .systemPurple
        view.addSubview(table.view)
        table.didMove(toParent: self)
        
        table.view.snp.makeConstraints { make in
            make.top.trailing.bottom.leading.equalTo(view)
        }
    }
}
