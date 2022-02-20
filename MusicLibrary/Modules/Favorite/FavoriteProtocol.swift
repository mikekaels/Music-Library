//
//  FavoriteProtocol.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.

import Foundation

public protocol FavoriteDelegate {
    
}

protocol FavoriteViewToPresenterProtocol: AnyObject {
    var view: FavoritePresenterToViewProtocol? { get set }
    var interactor: FavoritePresenterToInteractorProtocol? { get set }
    var router: FavoritePresenterToRouterProtocol? { get set }
    
    func fetchFavorites()
    func removeFavorite(id: NSNumber)
}

protocol FavoritePresenterToRouterProtocol: AnyObject {
    func createModule() -> FavoriteVC
}

protocol FavoritePresenterToViewProtocol: AnyObject {
    func didFetchFavorite(favorites: [FavoriteSongs])
    func didRemoveFromFavorite()
}

protocol FavoriteInteractorToPresenterProtocol: AnyObject {
    func didFetchFavorite(favorites: [FavoriteSongs])
    func didRemoveFromFavorite()
}

protocol FavoritePresenterToInteractorProtocol: AnyObject {
    var presenter: FavoriteInteractorToPresenterProtocol? { get set }
    func fetchFavorites()
    func removeFavorite(id: NSNumber)
}
