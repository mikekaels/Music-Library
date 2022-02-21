//
//  LibraryProtocol.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.

import Foundation

public protocol LibraryDelegate {
    func dataUpdated()
}

protocol LibraryViewToPresenterProtocol: AnyObject {
    var view: LibraryPresenterToViewProtocol? { get set }
    var interactor: LibraryPresenterToInteractorProtocol? { get set }
    var router: LibraryPresenterToRouterProtocol? { get set }
    
    func fetchChart(page: Int, pageSize: Int)
    func addToFavorite(trackList: [TrackList])
    func deleteFromFavorite(id: NSNumber)
    func addToFavorite(id: NSNumber)
    func findSongs(page: Int, pageSize: Int, query: String)
    func fetchRandomImage()
}

protocol LibraryPresenterToRouterProtocol: AnyObject {
    func createModule() -> LibraryVC
}

protocol LibraryPresenterToViewProtocol: AnyObject {
    func didFailFetchChart(error: CustomError)
    func didFetchFavorite(songs: [SongsModel])
    func didFailFavorite(error: CustomError)
    
}

protocol LibraryInteractorToPresenterProtocol: AnyObject {
    func didFetchChart(result: Result<MusicModel, CustomError>)
    
    func didFetchFavorite(result: Result<[SongsModel], CustomError>)
}

protocol LibraryPresenterToInteractorProtocol: AnyObject {
    var presenter: LibraryInteractorToPresenterProtocol? { get set }
    func fetchChart(page: Int, pageSize: Int)
    func findSongs(page: Int, pageSize: Int, query: String)
    func addToFavorite(songs: [SongsModel])
    func deleteFromFavorite(id: NSNumber)
    func addToFavorite(id: NSNumber)
    func fetchRandomImage()
}
