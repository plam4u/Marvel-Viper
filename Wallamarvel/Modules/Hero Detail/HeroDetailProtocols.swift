//
//  HeroDetailProtocols.swift
//  Wallamarvel
//
//  Created by Juanjo García Villaescusa on 21/5/17.
//  Copyright © 2017 Juanjo García Villaescusa. All rights reserved.
//

import UIKit

protocol HeroDetailViewProtocol: class {
    
    var presenter: HeroDetailPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showHeroDetail(forHero hero: Hero)
}

protocol HeroDetailWireframeProtocol: class {
    static func createHeroDetailModule(forHero hero: Hero?) -> UIViewController?
}

protocol HeroDetailPresenterProtocol: class {
    var view: HeroDetailViewProtocol? { get set }
    var wireFrame: HeroDetailWireframeProtocol? { get set }
    var hero: Hero? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
}
