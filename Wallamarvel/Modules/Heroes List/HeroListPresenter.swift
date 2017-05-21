//
//  HeroListPresenter.swift
//  Wallamarvel
//
//  Created by Juanjo García Villaescusa on 21/5/17.
//  Copyright © 2017 Juanjo García Villaescusa. All rights reserved.
//

import Foundation

class HeroListPresenter: HeroListPresenterProtocol {
    
    var view: HeroListViewProtocol?
    var interactor: HeroListInteractorInputProtocol?
    var wireFrame: HeroListWireframeProtocol?
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.retrieveAllHeroes()
    }
    
    func tableViewReachedBottom() {
        view?.showLoading()
        interactor?.retrieveAllHeroes()
    }
    
    func tableViewReachedBottom(search: String) {
        view?.showLoading()
        interactor?.searchHeroes(searchString: search)
    }
    
    func search(_ string: String) {
        
        if string == "" {
            return
        }
        
        view?.showLoading()
        interactor?.searchHeroes(searchString: string)
    }
    
    func showHeroDetail(forHero hero: Hero) {
        if let view = view {
            wireFrame?.presentHeroDetailScreen(from: view, forHeroe: hero)
        }
    }
}

extension HeroListPresenter: HeroListInteractorOutputProtocol {
    
    func didRetrieveHeroes(_ heroes: [Hero]) {
        view?.hideLoading()
        view?.showHeroes(with: heroes)
    }
    
    func onError() {
        view?.showError()
    }
}
