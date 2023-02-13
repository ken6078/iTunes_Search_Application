//
//  SongListView.swift
//  iTunesSearch
//
//  Created by Jacky Ben on 2023/2/3.
//

import SwiftUI

struct SearchListView: View {
    @State var searchText = ""
    @State var searchTypes: [String] = [ "歌曲", "專輯", "歌手"]
    @State private var selectedType = "歌曲"
    @StateObject var songListViewModel = SongListViewModel()
    @StateObject var albumListViewModel = AlbumListViewModel()
    @StateObject var artistListViewModel = ArtistListViewModel()
    var body: some View {
        NavigationView{
            VStack {
                Picker(selection: $selectedType) {
                    ForEach(searchTypes, id: \.self) { type in
                        Text(type)
                    }
                } label: {}
                    .pickerStyle(.segmented)
                    .padding(10)
                switch (selectedType){
                    case "歌曲":
                        SearchSongView(songListViewModel: songListViewModel)
                    case "專輯":
                        SearchAlbumView(albumListViewModel: albumListViewModel)
                    case "歌手":
                        SearchArtistView(artistListViewModel: artistListViewModel)
                    default:
                        EmptyView()
                }
                
            }
            .listStyle(.plain)
            .navigationBarTitle("搜尋")
            .searchable(text: $searchText)
        }
        .onChange(of: searchText) { newValue in
            songListViewModel.searchText = newValue
            albumListViewModel.searchText = newValue
            artistListViewModel.searchText = newValue
        }
    }
}

struct SongListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListView()
    }
}
