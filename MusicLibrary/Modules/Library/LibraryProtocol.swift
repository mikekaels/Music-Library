//
//  LibraryProtocol.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.

public protocol LibraryDelegate {
    
}

protocol LibraryViewToPresenterProtocol: AnyObject {
    var view: LibraryPresenterToViewProtocol? { get set }
    var interactor: LibraryPresenterToInteractorProtocol? { get set }
    var router: LibraryPresenterToRouterProtocol? { get set }
}

protocol LibraryPresenterToRouterProtocol: AnyObject {
    func createModule() -> LibraryVC
}

protocol LibraryPresenterToViewProtocol: AnyObject {

}

protocol LibraryInteractorToPresenterProtocol: AnyObject {

}

protocol LibraryPresenterToInteractorProtocol: AnyObject {
    var presenter: LibraryInteractorToPresenterProtocol? { get set }

}
