//
//  FilmsTableViewController.swift
//  Internship_Cogniteq
//
//  Created by Siarova Katsiaryna on 5.03.21.
//

import UIKit

class FilmsTableViewController: UITableViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private var films: Films?
    private var isLoading = false {
        didSet {
            updateLayout()
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Popular"
        
        NetworkService.loadFilms(successHandler: { [weak self] films in
            self?.films = films
            self?.tableView.reloadData()
            self?.isLoading = false
        }, failureHandler: { error in
            print("response error: \(error)")
        })
        
        let filmCell = UINib(nibName: "FilmCell", bundle: nil)
        tableView?.register(filmCell, forCellReuseIdentifier: "FilmCell")
        tableView?.delegate = self
        tableView?.dataSource = self
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films?.results?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        134
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as? FilmCell else {
            return UITableViewCell()
        }
        
        let title = films?.results?[indexPath.row].title
        let overview = films?.results?[indexPath.row].overview
        let year = films?.results?[indexPath.row].getYear()
        let posterPath = films?.results?[indexPath.row].posterPath
        cell.configure(posterPath: posterPath, title: title, overview: overview, year: year)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "OverviewViewController") as? OverviewViewController {
            vc.film = films?.results?[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    private func updateLayout() {
        if isLoading {
            if !spinner.isAnimating {
                spinner.startAnimating()
                spinner.isHidden = false
            }
        } else if spinner.isAnimating {
            spinner.stopAnimating()
        }
    }
}
