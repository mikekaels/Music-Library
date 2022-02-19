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
    
    func fetchChart(page: Int, pageSize: Int)
}

protocol LibraryPresenterToRouterProtocol: AnyObject {
    func createModule() -> LibraryVC
}

protocol LibraryPresenterToViewProtocol: AnyObject {
    func didSuccesFetchChart(music: [TrackList])
    func didFailFetchChart(error: CustomError)
}

protocol LibraryInteractorToPresenterProtocol: AnyObject {
    func didFetchChart(result: Result<MusicModel, CustomError>)
}

protocol LibraryPresenterToInteractorProtocol: AnyObject {
    var presenter: LibraryInteractorToPresenterProtocol? { get set }
    func fetchChart(page: Int, pageSize: Int)
}
