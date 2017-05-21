//
//  HeroDetailViewController.swift
//  Wallamarvel
//
//  Created by Juanjo García Villaescusa on 21/5/17.
//  Copyright © 2017 Juanjo García Villaescusa. All rights reserved.
//

import UIKit
import SDWebImage

class HeroDetailViewController: UIViewController {
    
    var presenter: HeroDetailPresenterProtocol?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
    }
}

extension HeroDetailViewController: HeroDetailViewProtocol {
    
    func showHeroDetail(forHero hero: Hero) {
        
        imageView.sd_setImage(with: hero.thumbURL)
        nameLabel.text = hero.name
        descriptionLabel.text = hero.description
    }
}
