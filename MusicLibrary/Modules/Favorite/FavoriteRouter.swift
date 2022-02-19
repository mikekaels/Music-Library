//
//  FavoriteRouter.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.

import UIKit

public class FavoriteRouter: FavoritePresenterToRouterProtocol{
    public static let shared = FavoriteRouter()
    
    func initialize() -> FavoriteVC {
        return createModule()
    }
    
    func createModule() -> FavoriteVC {
        let view = FavoriteVC()
        
        let presenter: FavoriteViewToPresenterProtocol & FavoriteInteractorToPresenterProtocol = FavoritePresenter()
        
        let interactor: FavoritePresenterToInteractorProtocol = FavoriteInteractor()
        
        let router: FavoritePresenterToRouterProtocol = FavoriteRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return view
    }
}
