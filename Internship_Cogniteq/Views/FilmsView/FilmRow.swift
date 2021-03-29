//
//  FilmRow.swift
//  Internship_Cogniteq
//
//  Created by Siarova Katsiaryna on 22.03.21.
//

import SwiftUI

struct FilmRow: View {
    @State var item: Films.Results
    
    var body: some View {
        HStack(alignment: .top) {
            ImageView(withURL: item.posterPath)
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)

            VStack(alignment: .leading) {
                Text(item.title ?? "Error")
                    .lineLimit(2)
                    .padding(.bottom, 4)
                    .font(.headline)

                Text(verbatim: item.overview ?? "")
                    .lineLimit(3)
                    .padding(.bottom, 4)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)

                Text(verbatim: item.getYear())
                    .foregroundColor(Color(UIColor.systemGray))
            }
            .frame(maxWidth: .infinity)
            .padding(.trailing, 16)
            .padding(.leading, 4)
            .font(.system(size: 12))
        
            Image(systemName: "chevron.forward")
                .padding(.trailing, 10)
                .foregroundColor(Color(UIColor.systemGray2))
        }
    }
}

struct FilmRow_Previews: PreviewProvider {
    static var previews: some View {
        FilmRow(item: Films.Results(posterPath: nil, adult: nil, overview: nil, releaseDate: nil, genreIds: nil, id: nil, originalTitle: nil, originalLanguage: nil, title: nil, backdropPath: nil, popularity: nil, voteCount: nil, video: nil, voteAverage: nil))
    }
}
