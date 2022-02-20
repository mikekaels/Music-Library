//
//  LibraryInteractor.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.

import Foundation

class LibraryInteractor: LibraryPresenterToInteractorProtocol {
    weak var presenter: LibraryInteractorToPresenterProtocol?
}

extension LibraryInteractor {
    func fetchChart(page: Int, pageSize: Int) {
        APIManager().fetchChart(page: page, pageSize: pageSize) {[weak self] result in
            self?.presenter?.didFetchChart(result: result)
        }
    }
    
    func findSongs(page: Int, pageSize: Int, songTitle: String) {
        APIManager().findSongs(page: page, pageSize: pageSize, songTitle: songTitle) { [weak self] result in
            self?.presenter?.didFetchChart(result: result)
        }
    }
    
    func addToFavorite(songs: [SongsModel]) {
        APIManager().addData(songs: songs) { [weak self] result in
            self?.presenter?.didFetchFavorite(result: result)
        }
    }
    
    func deleteFromFavorite(id: NSNumber) {
        APIManager().deleteData(id: id) { [weak self] result in
            
        }
    }
    
    func addToFavorite(id: NSNumber) {
        APIManager().addToFavorite(id: id) { [weak self] result in
            
        }
    }
    
    func fetchRandomImage() {
        APIManager()
    }
    
}
