//
//  ViewController.swift
//  RealmPokemon
//
//  Created by Alexander Schülke on 01.10.18.
//  Copyright © 2018 Alexander Schülke. All rights reserved.
//

import UIKit


enum CellIdentifier: String {
    case PokemonCell
}

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    lazy var viewModel: ListViewModel = {
        return ListViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Pokédex"
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self

        
        viewModel.startObserving {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
        
    }

}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.storedPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.PokemonCell.rawValue, for: indexPath) as? PokemonCell
            else { return UITableViewCell(style: .default, reuseIdentifier: nil)}
        
        if viewModel.storedPokemon.count > 0 {
            let stored = viewModel.getStoredPokemon(for: indexPath)
            cell.nameLabel.text = stored.name
            cell.nrLabel.text = stored.number
            cell.heightLabel.text = stored.height
            cell.weightLabel.text = stored.weight
        }
        return cell
    }
    
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //    showEditAlert()
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        viewModel.deletePokemon(at: indexPath)
    }
    

}

extension ListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if Int(searchBar.text!)! < 151 {
            viewModel.fetch(number: Int(searchBar.text!)!)
        }
    }
    
}
