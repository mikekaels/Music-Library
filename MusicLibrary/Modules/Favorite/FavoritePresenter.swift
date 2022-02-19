//
//  FavoritePresenter.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.

class FavoritePresenter: FavoriteViewToPresenterProtocol {
    weak var view: FavoritePresenterToViewProtocol?
    var router: FavoritePresenterToRouterProtocol?
    var interactor: FavoritePresenterToInteractorProtocol?
    
    
}

extension FavoritePresenter: FavoriteInteractorToPresenterProtocol {

}
