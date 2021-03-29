//
//  SearchRow.swift
//  Internship_Cogniteq
//
//  Created by Siarova Katsiaryna on 24.03.21.
//

import SwiftUI

struct SearchRow: View {
    @State var item: Films.Results

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title ?? "Error")
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, 10)
            .font(.system(size: 12))
            
            Text(verbatim: item.getYear())
                .foregroundColor(Color(UIColor.systemGray))
            
            Image(systemName: "chevron.forward")
                .padding(.trailing, 10)
                .foregroundColor(Color(UIColor.systemGray4))
        }
    }
}

struct SearchRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchRow(item: Films.Results(posterPath: nil, adult: nil, overview: nil, releaseDate: nil, genreIds: nil, id: nil, originalTitle: nil, originalLanguage: nil, title: nil, backdropPath: nil, popularity: nil, voteCount: nil, video: nil, voteAverage: nil))
    }
}
