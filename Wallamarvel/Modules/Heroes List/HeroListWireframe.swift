//
//  HeroListWireframe.swift
//  Wallamarvel
//
//  Created by Juanjo García Villaescusa on 21/5/17.
//  Copyright © 2017 Juanjo García Villaescusa. All rights reserved.
//

import UIKit

class HeroListWireframe: HeroListWireframeProtocol {
    
    static func createHeroListModule() -> UIViewController? {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainNavController = mainStoryboard.instantiateViewController(withIdentifier: "HeroListNavigationController")
        
        
        if let view = mainNavController.childViewControllers.first as? HeroListViewProtocol {
            
            let presenter: HeroListPresenterProtocol & HeroListInteractorOutputProtocol = HeroListPresenter()
            let interactor: HeroListInteractorInputProtocol & HeroListDataManagerOutputProtocol = HeroListInteractor()
            let dataManager: HeroListDataManagerInputProtocol = HeroListDataManager()
            let wireFrame: HeroListWireframeProtocol = HeroListWireframe()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.dataManager = dataManager
            dataManager.remoteRequestHandler = interactor
            
            return mainNavController
            
        } else {
            
            return nil
        }
    }
    
    func presentHeroDetailScreen(from view: HeroListViewProtocol, forHeroe hero: Hero) {
        
        if let sourceView = view as? UIViewController,
            let detailController = HeroDetailWireframe.createHeroDetailModule(forHero: hero) {
            sourceView.showDetailViewController(detailController, sender: view)
        }
    }
}
