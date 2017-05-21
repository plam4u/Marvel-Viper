//
//  HeroDetailPresenter.swift
//  Wallamarvel
//
//  Created by Juanjo García Villaescusa on 21/5/17.
//  Copyright © 2017 Juanjo García Villaescusa. All rights reserved.
//

import Foundation

class HeroDetailPresenter: HeroDetailPresenterProtocol {
    
    var view: HeroDetailViewProtocol?
    var wireFrame: HeroDetailWireframeProtocol?
    var hero: Hero?

    func viewDidLoad() {
        
        if let hero = hero {
            view?.showHeroDetail(forHero: hero)
        }
    }
}
