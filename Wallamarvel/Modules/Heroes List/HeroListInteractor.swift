//
//  HeroListInteractor.swift
//  Wallamarvel
//
//  Created by Juanjo García Villaescusa on 21/5/17.
//  Copyright © 2017 Juanjo García Villaescusa. All rights reserved.
//

import Foundation

class HeroListInteractor: HeroListInteractorInputProtocol {
    
    var presenter: HeroListInteractorOutputProtocol?
    var dataManager: HeroListDataManagerInputProtocol?
    
    func retrieveAllHeroes() {
        dataManager?.retrieveHeroList()
    }
    
    func searchHeroes(searchString: String) {
        dataManager?.retrieveHeroList(search: searchString)
    }
}

extension HeroListInteractor: HeroListDataManagerOutputProtocol {
    
    func onHeroesRetrieved(_ heroes: [Hero]) {
        presenter?.didRetrieveHeroes(heroes)
    }
    
    func onError() {
        presenter?.onError()
    }
}
