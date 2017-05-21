//
//  HeroesProtocols.swift
//  Wallamarvel
//
//  Created by Juanjo García Villaescusa on 21/5/17.
//  Copyright © 2017 Juanjo García Villaescusa. All rights reserved.
//

import UIKit

protocol HeroListViewProtocol: class {
    
    var presenter: HeroListPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showHeroes(with heroes: [Hero])
    func showError()
    func showLoading()
    func hideLoading()
}

protocol HeroListWireframeProtocol: class {
    
    static func createHeroListModule() -> UIViewController?
    
    // PRESENTER -> WIREFRAME
    func presentHeroDetailScreen(from view: HeroListViewProtocol, forHeroe hero: Hero)
}

protocol HeroListPresenterProtocol: class {
    
    var view: HeroListViewProtocol? { get set }
    var interactor: HeroListInteractorInputProtocol? { get set }
    var wireFrame: HeroListWireframeProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func tableViewReachedBottom()
    func search(_ string: String)
    func tableViewReachedBottom(search: String)
    func showHeroDetail(forHero hero: Hero)
}

protocol HeroListInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func didRetrieveHeroes(_ heroes: [Hero])
    func onError()
}

protocol HeroListInteractorInputProtocol: class {
    
    var presenter: HeroListInteractorOutputProtocol? { get set }
    var dataManager: HeroListDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveAllHeroes()
    func searchHeroes(searchString: String)
}

protocol HeroListDataManagerInputProtocol: class {
    
    var remoteRequestHandler: HeroListDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveHeroList()
    func retrieveHeroList(search: String)
}

protocol HeroListDataManagerOutputProtocol: class {
    
    // REMOTEDATAMANAGER -> INTERACTOR
    func onHeroesRetrieved(_ heroes: [Hero])
    func onError()
}
