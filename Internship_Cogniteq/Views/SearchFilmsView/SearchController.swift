//
//  SearchView.swift
//  Internship_Cogniteq
//
//  Created by Siarova Katsiaryna on 23.03.21.
//

import SwiftUI
import UIKit

final class SearchController: UIHostingController<SearchView>, UISearchResultsUpdating {
    private let search = UISearchController(searchResultsController: nil)
    private let state = SearchState()
    
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
    
    func addSearchBar() {
        search.searchBar.placeholder = "Search..."
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        self.navigationItem.searchController = search
    }
}

extension SearchController: FilmsViewProtocol {
    func openDetailView(item: Films.Results) {
        let detailController = FilmDetailController(item)
        detailController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(detailController, animated: true)
    }
}
