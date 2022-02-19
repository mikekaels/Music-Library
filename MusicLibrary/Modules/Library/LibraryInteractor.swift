//
//  LibraryInteractor.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.

class LibraryInteractor: LibraryPresenterToInteractorProtocol {
    weak var presenter: LibraryInteractorToPresenterProtocol?
}

extension LibraryInteractor {
    func fetchChart(page: Int, pageSize: Int) {
        APIManager().fetchChart(page: page, pageSize: pageSize) {[weak self] result in
            self?.presenter?.didFetchChart(result: result)
        }
    }
}
