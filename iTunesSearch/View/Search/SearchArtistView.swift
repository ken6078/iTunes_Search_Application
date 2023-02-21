//
//  SearchArtistView.swift
//  iTunesSearch
//
//  Created by Jacky Ben on 2023/2/13.
//

import SwiftUI

struct SearchArtistView: View {
    @StateObject var artistListViewModel: ArtistListViewModel
    var body: some View {
        List{
            ForEach(artistListViewModel.artists) { artist in
                NavigationLink(destination: ArtistView(artistId: artist.id)){
                    HStack {
                        HtmlUrlImageView(
                            urlString: artist.artistLinkURL,
                            magnification: 1.5,
                            pictureHtmlIndex: 16
                        )
                        VStack(alignment: .leading) {
                            Text(artist.artistName)
                        }
                        Spacer()
                    }
                }
                .contentShape(Rectangle())
                
            }
            switch artistListViewModel.state {
                case .empty:
                    EmptyView()
                case .good:
                    Color.clear
                        .onAppear(){
                            artistListViewModel.loadMore()
                        }
                case .isLoading:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(maxWidth: .infinity)
                case .loadedAll:
                    EmptyView()
                case .error(let message):
                    Text(message)
                        .foregroundColor(.pink)
            }
        }
    }
}

struct SearchArtistView_Previews: PreviewProvider {
    static var previews: some View {
        SearchArtistView(artistListViewModel: ArtistListViewModel.example())
    }
}
