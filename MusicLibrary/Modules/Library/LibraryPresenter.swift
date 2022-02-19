//
//  LibraryPresenter.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.

class LibraryPresenter: LibraryViewToPresenterProtocol {
    weak var view: LibraryPresenterToViewProtocol?
    var router: LibraryPresenterToRouterProtocol?
    var interactor: LibraryPresenterToInteractorProtocol?
    
    func fetchChart(page: Int, pageSize: Int) {
        interactor?.fetchChart(page: page, pageSize: pageSize)
    }
}

extension LibraryPresenter: LibraryInteractorToPresenterProtocol {
    func didFetchChart(result: Result<MusicModel, CustomError>) {
        switch result {
        case .success(let music):
            view?.didSuccesFetchChart(music: (music.message?.body?.trackList)!)
        case .failure(let error):
            view?.didFailFetchChart(error: .unexpected)
        }
    }
    
    
}
