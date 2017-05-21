//
//  HeroDetailWireframe.swift
//  Wallamarvel
//
//  Created by Juanjo García Villaescusa on 21/5/17.
//  Copyright © 2017 Juanjo García Villaescusa. All rights reserved.
//

import UIKit


class HeroDetailWireframe: HeroDetailWireframeProtocol {
    
    static func createHeroDetailModule(forHero hero: Hero?) -> UIViewController? {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let detailController = mainStoryboard.instantiateViewController(withIdentifier: "HeroDetailViewController")
        
        if let view = detailController as? HeroDetailViewController {

            let presenter: HeroDetailPresenterProtocol = HeroDetailPresenter()
            let wireFrame: HeroDetailWireframeProtocol = HeroDetailWireframe()
            
            view.presenter = presenter
            presenter.view = view
            presenter.hero = hero
            presenter.wireFrame = wireFrame
            
            return view
        }
        
        return nil
    }
}
