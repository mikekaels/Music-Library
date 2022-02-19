//
//  TabBarRouter.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.

import UIKit

public class TabBarRouter: TabBarPresenterToRouterProtocol{
    public static let shared = TabBarRouter()
    
    func initialize() -> TabBarVC {
        return createModule()
    }
    
    func createModule() -> TabBarVC {
        let view = TabBarVC()
        
        let presenter: TabBarViewToPresenterProtocol & TabBarInteractorToPresenterProtocol = TabBarPresenter()
        
        let interactor: TabBarPresenterToInteractorProtocol = TabBarInteractor()
        
        let router: TabBarPresenterToRouterProtocol = TabBarRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return view
    }
}
