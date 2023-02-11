//
//  SongListView.swift
//  iTunesSearch
//
//  Created by Jacky Ben on 2023/2/3.
//

import SwiftUI

struct SearchListView: View {
    @State var searchText: String = ""
    @State var searchTypes: [String] = ["歌手", "歌曲", "專輯"]
    @StateObject var songListViewModel = SongListViewModel()
    var body: some View {
        NavigationView{
            List{
                ForEach(songListViewModel.songs) { song in
                    Button(action: {
                        print("onTap: \(song.trackName), \(song.artistID)")
                    }, label:{
                        HStack {
                            UrlImageView(urlString: song.artworkUrl60)
                            VStack(alignment: .leading) {
                                Text(song.trackName)
                                Text(song.artistName)
                                    .foregroundColor(Color.gray)
                            }
                            Spacer()
                        }}
                    )
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
            .listStyle(.plain)
            .navigationBarTitle("搜尋")
            .searchable(text: $songListViewModel.searchText)
        }
    }
}

struct SongListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListView()
    }
}
