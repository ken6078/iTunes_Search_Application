//
//  SongListView.swift
//  iTunesSearch
//
//  Created by Jacky Ben on 2023/2/3.
//

import SwiftUI

// TODO: xxx - 歌手, xxx - 歌曲, xxx - 專輯
struct SearchListView: View {
    @State var searchText: String = "煎熬"
    @State var searchTypes: [String] = ["歌手", "歌曲", "專輯"]
    @StateObject var songListViewModel = SongListViewModel()
    var body: some View {
        NavigationView{
            List{
                ForEach(songListViewModel.songs) { song in
                    Text(song.trackName)
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
