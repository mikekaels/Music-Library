//
//  LibraryPresenter.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.

import Foundation
import Alamofire
import CoreData

class LibraryPresenter: LibraryViewToPresenterProtocol {
    weak var view: LibraryPresenterToViewProtocol?
    var router: LibraryPresenterToRouterProtocol?
    var interactor: LibraryPresenterToInteractorProtocol?
    
    func fetchChart(page: Int, pageSize: Int) {
        interactor?.fetchChart(page: page, pageSize: pageSize)
    }
    
    func findSongs(page: Int, pageSize: Int, query: String) {
        interactor?.findSongs(page: page, pageSize: pageSize, query: query)
    }
    
    func deleteFromFavorite(id: NSNumber) {
        interactor?.deleteFromFavorite(id: id)
    }
    
    func addToFavorite(id: NSNumber) {
        interactor?.addToFavorite(id: id)
    }
    
    func fetchRandomImage() {
        interactor?.fetchRandomImage()
    }
}

extension LibraryPresenter: LibraryInteractorToPresenterProtocol {
    func didFetchFavorite(result: Result<[SongsModel], CustomError>) {
        switch result {
        case .success(let songs):
            view?.didFetchFavorite(songs: songs)
        case .failure(let err):
            view?.didFailFavorite(error: err)
        }
    }
    
    func didFetchChart(result: Result<MusicModel, CustomError>) {
        switch result {
        case .success(let music):
            self.addToFavorite(trackList: (music.message?.body?.trackList)!)
        case .failure(let error):
            view?.didFailFetchChart(error: error)
        }
    }
    
    
}

extension LibraryPresenter {
    func addToFavorite(trackList: [TrackList]) {
        
        var newSongs : [SongsModel] = [SongsModel]()
        
        trackList.forEach { item in
            let favoriteSong = SongsModel(id: NSNumber(value: (item.track?.trackID)!), songTitle: (item.track?.trackName)!, singer: (item.track?.artistName)!, dateAdded: Date(), saved: 0, image: "")
            
            newSongs.append(favoriteSong)
        }
        
        interactor?.addToFavorite(songs: newSongs)
    }
}
