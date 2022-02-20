//
//  FavoriteInteractor.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.

import Foundation

class FavoriteInteractor: FavoritePresenterToInteractorProtocol {
    
    weak var presenter: FavoriteInteractorToPresenterProtocol?
}

extension FavoriteInteractor {
    func fetchFavorites() {
        APIManager().getAllFavorite() { [weak self] result in
            self?.presenter?.didFetchFavorite(favorites: result)
        }
    }
    
    func removeFavorite(id: NSNumber) {
        APIManager().deleteData(id: id) { [weak self] result in
            self?.presenter?.didRemoveFromFavorite()
        }
    }
}
