//
//  SearchView.swift
//  Internship_Cogniteq
//
//  Created by Siarova Katsiaryna on 23.03.21.
//

import Combine
import SwiftUI
import UIKit

final class SearchState: ObservableObject {
    @Published var films = [Films.Results]()
    
    weak var controller: SearchController?
    private var cancellable = Set<AnyCancellable>()

    func loadData(_ query: String) {
        if query.isEmpty {
            NetworkService.loadFilms()
                .receive(on: RunLoop.main)
                .sink { error in
                    print(error)
                } receiveValue: { results in
                    self.films = results
                }
                .store(in: &cancellable)
        } else {
            NetworkService.loadSuitableFilms(query: query)
                .receive(on: RunLoop.main)
                .sink { error in
                    print(error)
                } receiveValue: { results in
                    self.films = results
                }
                .store(in: &cancellable)
        }
    }
}

final class SearchController: UIHostingController<SearchView>, UISearchResultsUpdating, UISearchBarDelegate  {
    private let search = UISearchController(searchResultsController: nil)
    private let state = SearchState()
    private let networkService = NetworkService()
    private var cancellable: AnyCancellable?

    override func viewDidLoad() {
        cancellable?.cancel()
    }
    
    init() {
        let view = SearchView(state: state)
        super.init(rootView: view)
        state.loadData("")
        state.controller = self
        addSearchBar()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        let view = SearchView(state: state)
        super.init(coder: aDecoder, rootView: view)
        state.controller = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        state.loadData(searchController.searchBar.text!.lowercased())
    }
    
    func openDetailView(item: Films.Results) {
        let detailController = FilmDetailController(item)
        detailController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    func addSearchBar() {
        search.searchBar.placeholder = "Search..."
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.delegate = self
        self.definesPresentationContext = true
        self.navigationItem.searchController = search
    }
}
