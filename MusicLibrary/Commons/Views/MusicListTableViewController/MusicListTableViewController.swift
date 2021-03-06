//
//  MusicListTableViewController.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.
//

import UIKit

class MusicListTableViewController<T, Cell: UITableViewCell>: UITableViewController {
    var delegare: LibraryDelegate?
    
    var items: [T] {
        didSet {
            self.tableView.reloadData()
        }
    }
    var configure: (SongTableViewCell, T) -> Void
    var selectHandler: (T) -> Void
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(items: [T], configure: @escaping (SongTableViewCell, T) -> Void, selectHandler: @escaping (T) -> Void) {
        self.items = items
        self.configure = configure
        self.selectHandler = selectHandler
        super.init(style: .plain)
        self.tableView.register(SongTableViewCell.self, forCellReuseIdentifier: Identifiers.SongTableViewCell)
        self.tableView.contentInset.top = 20
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .clear
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.SongTableViewCell, for: indexPath) as! SongTableViewCell
        let item = items[indexPath.row]
        cell.index = indexPath.row + 1
        configure(cell, item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        selectHandler(item)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension MusicListTableViewController: LibraryDelegate {
    func dataUpdated() {
        self.tableView.reloadData()
    }
    
}
