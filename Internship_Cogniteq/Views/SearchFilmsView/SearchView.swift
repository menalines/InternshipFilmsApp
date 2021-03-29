//
//  SearchView.swift
//  Internship_Cogniteq
//
//  Created by Siarova Katsiaryna on 30.03.21.
//

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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(state: SearchState())
    }
}

protocol SearchViewProtocol {
    func openDetailView()
}
