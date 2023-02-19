//
//  SearchSongView.swift
//  iTunesSearch
//
//  Created by Jacky Ben on 2023/2/11.
//

import SwiftUI

struct SearchSongView: View {
    @StateObject var songListViewModel: SongListViewModel
    var body: some View {
        List{
            ForEach(songListViewModel.songs) { song in
                NavigationLink(destination:
                                SongView(
                                    song: song,
                                    shareUrl: URL(string: song.collectionViewURL)!
                                )){
                                    HStack {
                                        UrlImageView(urlString: song.artworkUrl60)
                                        VStack(alignment: .leading) {
                                            Text(song.trackName)
                                                .lineLimit(2)
                                            Text(song.artistName)
                                                .foregroundColor(Color.gray)
                                        }
                                        Spacer()
                                    }
                }
                .contentShape(Rectangle())
                
            }
            switch songListViewModel.state {
                case .empty:
                    EmptyView()
                case .good:
                    Color.clear
                        .onAppear(){
                            songListViewModel.loadMore()
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

struct SearchSongView_Previews: PreviewProvider {
    static var previews: some View {
        SearchSongView(songListViewModel: SongListViewModel.example())
    }
}
