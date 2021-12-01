//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var go: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var movieCellReuseIdentifier = "movieCell"
    var filteredItems : [Movie] = []
    private lazy var dataSource = makeDataSource()
    private var selectedItem : Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       // tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: movieCellReuseIdentifier)
        tableView.dataSource = dataSource
        tableView.delegate = self
        serviceCall(query: "star")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SearchViewController.backgroundGestureTapped(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func backgroundGestureTapped(_ sender: UIGestureRecognizer) {
        searchbar.resignFirstResponder()
    }
    
    private func serviceCall(query : String) {
        let network = Network()
        network.getMovies(query: query, completion: { [weak self] result in
            switch result {
            case .failure(let error) :
                self?.filteredItems = []
                self?.update()
                debugPrint(error)
            case .success(let movies):
                self?.filteredItems = movies
                self?.update()
            }
        })
    }
    
   private func updateFilter() {
        if let searchText = searchbar.text, searchText.isEmpty == false {
            serviceCall(query : searchText)
        }
    }
    
    @IBAction func goButton(_ sender: Any) {
        updateFilter()
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func makeDataSource() -> UITableViewDiffableDataSource<Int, Movie> {
        let reuseIdentifier = "movieCell"
        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, item in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? MovieTableViewCell else {
                    return nil
                }
                
                guard (item.title != nil) else {
                    return nil
                }
                
                cell.setUp(model: item)

                return cell
            })
    }
    
    func update() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Movie>()
        snapshot.appendSections([0])
        snapshot.appendItems(filteredItems, toSection: 0)

        dataSource.apply(snapshot)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedItem = filteredItems[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? MovieDetailViewController {
                destinationVC.filteredItem = selectedItem
            }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        updateFilter()
    }
}
