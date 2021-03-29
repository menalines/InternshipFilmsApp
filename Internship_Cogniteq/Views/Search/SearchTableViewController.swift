//
//  SearchTableViewController.swift
//  Internship_Cogniteq
//
//  Created by Siarova Katsiaryna on 10.03.21.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate {

    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text ?? "")
        if let query = searchController.searchBar.text {
        NetworkService.loadSuitableFilms(query: query, successHandler: { [weak self] films in
            self?.films = films
            self?.tableView.reloadData()
        }, failureHandler: { error in
            print("response error: \(error)")
        })
        }
    }

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private var films: Films?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkService.loadFilms(successHandler: { [weak self] films in
            self?.films = films
            self?.tableView.reloadData()
        }, failureHandler: { error in
            print("response error: \(error)")
        })
        
        let searchCell = UINib(nibName: "SearchCell", bundle: nil)
        tableView?.register(searchCell, forCellReuseIdentifier: "SearchCell")
        tableView?.delegate = self
        tableView?.dataSource = self
        
        tableView.tableFooterView = UIView()

        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false

        navigationItem.searchController = searchController
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films?.results?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell else {
            return UITableViewCell()
        }
        
        let title = films?.results?[indexPath.row].title
        let year = films?.results?[indexPath.row].getYear()
        cell.configure(title: title, year: year)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "OverviewViewController") as? OverviewViewController {
            vc.film = films?.results?[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
