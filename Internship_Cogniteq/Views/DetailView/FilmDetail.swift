//
//  FilmDetail.swift
//  Internship_Cogniteq
//
//  Created by Siarova Katsiaryna on 22.03.21.
//
//

import SwiftUI

struct FilmDetail: View {
    @ObservedObject var state: FilmDetailState

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .center) {
                    ImageView(withURL: state.item.posterPath)
                        .aspectRatio(contentMode: .fit)

                    VStack(alignment: .leading) {
                        Text(state.item.title ?? "")
                            .font(.headline)
                            .padding(.top, 8)
                            .padding(.bottom, 4)
                        
                        Text(verbatim: state.item.overview ?? "")
                            .font(.body)
                            .foregroundColor(Color(UIColor.darkGray))
                            .padding(.bottom, 12)
                        
                        Text(verbatim: state.item.getYear())
                            .font(.footnote)
                            .foregroundColor(Color(UIColor.darkGray))
                            .padding(.leading, 8)
                            .padding(.bottom, 16)
                    }
                    .padding(.leading, 12)
                    .padding(.trailing, 12)
                }
            }
        }
    }
}

final class FilmDetailState: ObservableObject {
    weak var controller: FilmDetailController?
    @Published var item: Films.Results
    
    init(item: Films.Results) {
        self.item = item
    }
}

final class FilmDetailController: UIHostingController<FilmDetail> {
    var state: FilmDetailState
    
    init(_ item: Films.Results) {
        state = FilmDetailState(item: item)
        let view = FilmDetail(state: state)
        super.init(rootView: view)
        state.controller = self
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        state = FilmDetailState(item: Films.Results(posterPath: nil, adult: nil, overview: nil, releaseDate: nil, genreIds: nil, id: nil, originalTitle: nil, originalLanguage: nil, title: nil, backdropPath: nil, popularity: nil, voteCount: nil, video: nil, voteAverage: nil))
        let view = FilmDetail(state: state)
        super.init(coder: aDecoder, rootView: view)
        state.controller = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
}

struct FilmDetail_Previews: PreviewProvider {
    static var previews: some View {
        FilmDetail(state: FilmDetailState(item: Films.Results(posterPath: nil, adult: nil, overview: nil, releaseDate: nil, genreIds: nil, id: nil, originalTitle: nil, originalLanguage: nil, title: nil, backdropPath: nil, popularity: nil, voteCount: nil, video: nil, voteAverage: nil)))
    }
}
