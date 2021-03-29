//
//  SearchView.swift
//  Internship_Cogniteq
//
//  Created by Siarova Katsiaryna on 30.03.21.
//

import Combine
import SwiftUI
import UIKit

struct SearchView: View {
    @ObservedObject var state: SearchState
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .center) {
                ForEach(state.films, id: \.self) { item in
                    VStack {
                        SearchRow(item: item)
                        Divider()
                            .padding(.horizontal, 5)
                            .frame(maxWidth: .infinity)
                    }
                    .onTapGesture {
                        state.controller?.openDetailView(item: item)
                    }
                }
            }
            .navigationBarTitle(Text("Search"))
        }
    }
}

final class SearchState: ObservableObject {
    @Published var films = [Films.Results]()
    
    weak var controller: SearchController?
    private var cancellable = Set<AnyCancellable>()

    func loadData(_ query: String) {
        let publisher = query.isEmpty ?
            NetworkService.loadFilms() :
            NetworkService.loadSuitableFilms(query: query)
        
        publisher
            .receive(on: RunLoop.main)
            .sink { error in
                print(error)
            } receiveValue: { results in
                self.films = results
            }
            .store(in: &cancellable)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(state: SearchState())
    }
}
