//
//  HeroListDataManager.swift
//  Wallamarvel
//
//  Created by Juanjo García Villaescusa on 21/5/17.
//  Copyright © 2017 Juanjo García Villaescusa. All rights reserved.
//

import Foundation

class HeroListDataManager: HeroListDataManagerInputProtocol {
    
    var remoteRequestHandler: HeroListDataManagerOutputProtocol?
    
    lazy var unfilteredListOfHeroes: [Hero] = []
    
    
    
    var currentSearch: String? {
        didSet {
            filteredListOfHeroes = []
        }
    }
    lazy var filteredListOfHeroes: [Hero] = []
    
    func retrieveHeroList() {
        
        HeroEndpoint().getHeroes(start: unfilteredListOfHeroes.count, count: 10) {
            
            response in
            
            guard response.isSuccess, let heroes = response.value else  {
                self.remoteRequestHandler?.onError()
                return
            }
            
            self.unfilteredListOfHeroes.append(contentsOf: heroes)
            
            self.remoteRequestHandler?.onHeroesRetrieved(self.unfilteredListOfHeroes)
        }
    }
    
    func retrieveHeroList(search: String) {
        
        if currentSearch != search {
            currentSearch = search
        }
        
        HeroEndpoint().searchHeroes(searchString: search, start: filteredListOfHeroes.count, count: 10) {
            
            response in
            
            guard response.isSuccess, let heroes = response.value else  {
                self.remoteRequestHandler?.onError()
                return
            }
            
            self.filteredListOfHeroes.append(contentsOf: heroes)
            
            self.remoteRequestHandler?.onHeroesRetrieved(self.filteredListOfHeroes)
        }
        
    }
}

