//
//  LibraryRouter.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.

import UIKit

public class LibraryRouter: LibraryPresenterToRouterProtocol{
    public static let shared = LibraryRouter()
    
    func initialize() -> LibraryVC {
        return createModule()
    }
    
    func createModule() -> LibraryVC {
        let view = LibraryVC()
        
        let presenter: LibraryViewToPresenterProtocol & LibraryInteractorToPresenterProtocol = LibraryPresenter()
        
        let interactor: LibraryPresenterToInteractorProtocol = LibraryInteractor()
        
        let router: LibraryPresenterToRouterProtocol = LibraryRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return view
    }
}
