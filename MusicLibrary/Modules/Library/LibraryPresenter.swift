//
//  LibraryPresenter.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.

class LibraryPresenter: LibraryViewToPresenterProtocol {
    weak var view: LibraryPresenterToViewProtocol?
    var router: LibraryPresenterToRouterProtocol?
    var interactor: LibraryPresenterToInteractorProtocol?
    
    
}

extension LibraryPresenter: LibraryInteractorToPresenterProtocol {

}
