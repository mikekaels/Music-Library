//
//  FavoriteProtocol.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.

public protocol FavoriteDelegate {
    
}

protocol FavoriteViewToPresenterProtocol: AnyObject {
    var view: FavoritePresenterToViewProtocol? { get set }
    var interactor: FavoritePresenterToInteractorProtocol? { get set }
    var router: FavoritePresenterToRouterProtocol? { get set }
}

protocol FavoritePresenterToRouterProtocol: AnyObject {
    func createModule() -> FavoriteVC
}

protocol FavoritePresenterToViewProtocol: AnyObject {

}

protocol FavoriteInteractorToPresenterProtocol: AnyObject {

}

protocol FavoritePresenterToInteractorProtocol: AnyObject {
    var presenter: FavoriteInteractorToPresenterProtocol? { get set }

}
