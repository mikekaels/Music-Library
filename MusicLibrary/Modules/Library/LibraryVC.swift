//
//  LibraryVC.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.

import UIKit
import SnapKit

class LibraryVC: UIViewController{
    var presentor: LibraryViewToPresenterProtocol?
    public var delegate: LibraryDelegate?
    var page = 1
    var pageSize = 10
    var songs : [SongsModel] = [SongsModel]()
    var searchText = ""
    
    let refreshControl = UIRefreshControl()
        .configure { v in
            v.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
            v.tintColor = Colors.title
        }
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Find Artist..."
        sc.searchBar.delegate = self
        sc.searchBar.barStyle = .black
        return sc
    }()
    
    lazy var table = MusicListTableViewController(items: [], configure: { (cell: SongTableViewCell, item: SongsModel) in
        cell.lblSongTitle.text = item.songTitle
        cell.lblSinger.text = item.singer
        cell.id = item.id
        cell.page = self.page
        cell.state = item.saved == 1 ? .saved : .add
        cell.data = item
        cell.delegate = self
    }) { (item) in
        print(item!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Library"
        setupUI()
        presentor?.fetchChart(page: self.page, pageSize: self.pageSize)
        receiveNC()
        table.tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        page += 1
        if searchText != "" {
            presentor?.findSongs(page: self.page, pageSize: self.pageSize, query: searchText)
        } else {
            presentor?.fetchChart(page: self.page, pageSize: self.pageSize)
        }
        
    }
    
    func receiveNC() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableData), name: NSNotification.Name("update.table.data.library"), object: nil)
    }
    
    func broadcastNC() {
        NotificationCenter.default.post(name: NSNotification.Name("update.table.data.favorite"),object: nil)
    }
    
    @objc func updateTableData() {
        if searchText != "" {
            presentor?.findSongs(page: page, pageSize: pageSize, query: searchText)
        } else {
            presentor?.fetchChart(page: page, pageSize: pageSize)
        }
    }
}

extension LibraryVC: LibraryPresenterToViewProtocol {
    func didFetchFavorite(songs: [SongsModel]) {
        self.songs = songs
        DispatchQueue.main.async { [weak self] in
            self?.table.items = self!.songs
            self?.refreshControl.endRefreshing()
        }
    }

    func didFailFavorite(error: CustomError) {
        self.refreshControl.endRefreshing()
        if error == .noInternetConnection {
            self.noInternetConnection(true) { [weak self] in
                if self?.searchText != "" {
                    self?.presentor?.findSongs(page: self!.page, pageSize: self!.pageSize, query: self!.searchText)
                } else {
                    self?.presentor?.fetchChart(page: self!.page, pageSize: self!.pageSize)
                }
            }
        }
    }
    
    func didFailFetchChart(error: CustomError) {
        self.refreshControl.endRefreshing()
        if error == .noInternetConnection {
            self.noInternetConnection(true) { [weak self] in
                if self!.searchText != "" {
                    self?.presentor?.findSongs(page: self!.page, pageSize: self!.pageSize, query: self!.searchText)
                } else {
                    self?.presentor?.fetchChart(page: self!.page, pageSize: self!.pageSize)
                }
            }
        }
    }
}

//MARK: - CELL DELEGATE
extension LibraryVC: SongCellDelegate {
    func addToFavorites(id: NSNumber, songTitle: String, singer: String) {
        presentor?.addToFavorite(id: id)
        self.delegate?.dataUpdated()
        broadcastNC()
    }
    
    func removeFromFavorite(id: NSNumber) {
        presentor?.deleteFromFavorite(id: id)
        broadcastNC()
    }
}



//MARK: - UISEARCHBAR DELEGATE
extension LibraryVC: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
    //MARK: - SEARCH CONTROL
    private func setupNavigationBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.page = 1
        if let searchText = searchBar.text {
            self.searchText = searchText
            presentor?.findSongs(page: page, pageSize: pageSize, query: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchText != "" {
            self.searchText = ""
            self.page = 1
            scrollToTop()
            presentor?.fetchChart(page: 1, pageSize: pageSize)
        }
    }
    
    func scrollToTop() {
        table.tableView.scrollToTop(animated: true)
    }
}

extension LibraryVC {
    func setupUI() {
        setupNavigationBar()
        
        addChild(table)
        view.backgroundColor = Colors.background
        view.addSubview(table.view)
        table.didMove(toParent: self)
        
        table.view.snp.makeConstraints { make in
            make.top.trailing.bottom.leading.equalTo(view)
        }
    }
}
