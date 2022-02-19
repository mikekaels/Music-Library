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
    
    let arr: [String] = ["A", "B", "C", "D"]
    
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
    
    lazy var table = MusicListTableViewController(items: [], configure: { (cell: SongTableViewCell, item) in
        cell.textLabel?.text = item as? String
    }) { (item) in
        print(item!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Library"
        setupNavigationBar()
        setupUI()
    }

}

extension LibraryVC: LibraryPresenterToViewProtocol {
    
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
        addChild(table)
        view.backgroundColor = .systemPurple
        view.addSubview(table.view)
        table.didMove(toParent: self)
        
        table.view.snp.makeConstraints { make in
            make.top.trailing.bottom.leading.equalTo(view)
        }
        
        table.items = arr
    }
}
