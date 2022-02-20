//
//  FavoritePresenter.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.

import Foundation

class FavoritePresenter: FavoriteViewToPresenterProtocol {
    weak var view: FavoritePresenterToViewProtocol?
    var router: FavoritePresenterToRouterProtocol?
    var interactor: FavoritePresenterToInteractorProtocol?
    
    func fetchFavorites() {
        interactor?.fetchFavorites()
    }
    
    func removeFavorite(id: NSNumber) {
        interactor?.removeFavorite(id: id)
    }
}

extension FavoritePresenter: FavoriteInteractorToPresenterProtocol {
    func didRemoveFromFavorite() {
        view?.didRemoveFromFavorite()
    }
    
    func didFetchFavorite(favorites: [FavoriteSongs]) {
        let savedSongs = favorites.filter { $0.saved == 1 }
        view?.didFetchFavorite(favorites: savedSongs)
    }
}
