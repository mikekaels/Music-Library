//
//  TabBarPresenter.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.

class TabBarPresenter: TabBarViewToPresenterProtocol {
    weak var view: TabBarPresenterToViewProtocol?
    var router: TabBarPresenterToRouterProtocol?
    var interactor: TabBarPresenterToInteractorProtocol?
    
    
}

extension TabBarPresenter: TabBarInteractorToPresenterProtocol {

}
