//
//  TabBarProtocol.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.

public protocol TabBarDelegate {
    
}

protocol TabBarViewToPresenterProtocol: AnyObject {
    var view: TabBarPresenterToViewProtocol? { get set }
    var interactor: TabBarPresenterToInteractorProtocol? { get set }
    var router: TabBarPresenterToRouterProtocol? { get set }
}

protocol TabBarPresenterToRouterProtocol: AnyObject {
    func createModule() -> TabBarVC
}

protocol TabBarPresenterToViewProtocol: AnyObject {

}

protocol TabBarInteractorToPresenterProtocol: AnyObject {

}

protocol TabBarPresenterToInteractorProtocol: AnyObject {
    var presenter: TabBarInteractorToPresenterProtocol? { get set }

}
