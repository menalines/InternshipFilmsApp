//
//  FilmsView.swift
//  Internship_Cogniteq
//
//  Created by Siarova Katsiaryna on 30.03.21.
//

import SwiftUI

struct FilmsView: View {
    @ObservedObject var state: FilmsState

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .center) {
                ForEach(state.films, id: \.self) { item in
                    VStack {
                        FilmRow(item: item)
                        Divider()
                            .padding(.horizontal, 4)
                            .frame(maxWidth: .infinity)
                    }
                    .onTapGesture {
                        state.controller?.openDetailView(item: item)
                    }
                }
            }
            .padding(.top, 8)
            .navigationBarTitle(Text("Popular"))
        }
    }
}

struct FilmsView_Previews: PreviewProvider {
    static var previews: some View {
        FilmsView(state: FilmsState())
    }
}

protocol FilmsViewProtocol {
    func openDetailView()
}
