//
//  ViewController.swift
//  Wallamarvel
//
//  Created by Juanjo García Villaescusa on 20/5/17.
//  Copyright © 2017 Juanjo García Villaescusa. All rights reserved.
//

import UIKit
import SDWebImage
import RKDropdownAlert

class HeroListViewController: UIViewController {
    
    var presenter: HeroListPresenterProtocol?
    
    var rows: [Hero]?
    var filteredRows: [Hero]?
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchTimer: Timer?
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var heroesTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // search controller setup
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.delegate = self
        definesPresentationContext = true
        heroesTableView.tableHeaderView = searchController.searchBar
        
        presenter?.viewDidLoad()
    }
}

extension HeroListViewController: HeroListViewProtocol {
    
    func showHeroes(with heroes: [Hero]) {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            filteredRows = heroes
        } else {
            rows = heroes
        }
        
        heroesTableView.reloadData()
        
        // loads detail for resular size
        if let firstHero = heroes.first, self.traitCollection.horizontalSizeClass == .regular {
            presenter?.showHeroDetail(forHero: firstHero)
        }
    }
    
    func showError() {
        RKDropdownAlert.title("Error", message: "Sorry, something went wrong")
    }
    
    func showLoading() {
        spinner.startAnimating()
    }
    
    func hideLoading() {
        spinner.stopAnimating()
    }
    
}

extension HeroListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredRows?.count ?? 0
        }
        
        return rows?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as! HeroCell
        
        let matchingHero = (searchController.isActive && searchController.searchBar.text != "") ? filteredRows![indexPath.row] : rows![indexPath.row]
        
        configure(cell: cell, hero: matchingHero)
        
        return cell
    }
    
    private func configure(cell: HeroCell, hero: Hero) {
        
        cell.previewImageView.sd_setImage(with: hero.thumbURL)
        cell.nameLabel.text = hero.name
    }
}

extension HeroListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive && searchController.searchBar.text != "" {
            presenter?.showHeroDetail(forHero: filteredRows![indexPath.row])
        } else {
            presenter?.showHeroDetail(forHero: rows![indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == rows!.count - 1 {
            if searchController.searchBar.text != "" {
                presenter?.tableViewReachedBottom(search: searchController.searchBar.text!)
            } else {
                presenter?.tableViewReachedBottom()
            }
        }
    }
}

extension HeroListViewController: UISearchResultsUpdating  {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: {
            timer in
            
            self.presenter?.search(searchController.searchBar.text!)
        })
    }
}

extension HeroListViewController: UISearchControllerDelegate {
    
    func didDismissSearchController(_ searchController: UISearchController) {
        
        filteredRows = []
        
        heroesTableView.reloadData()
    }
}

