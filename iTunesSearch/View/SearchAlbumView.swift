//
//  SearchAlbumView.swift
//  iTunesSearch
//
//  Created by Jacky Ben on 2023/2/12.
//

import SwiftUI

struct SearchAlbumView: View {
    @StateObject var albumListViewModel: AlbumListViewModel
    var body: some View {
        List{
            ForEach(albumListViewModel.albums) { album in
                Button(action: {
                    print("onTap: \(album.collectionName), \(album.artistName)")
                }, label:{
                    HStack {
                        UrlImageView(urlString: album.artworkUrl60)
                        VStack(alignment: .leading) {
                            Text(album.collectionName)
                            Text(album.artistName)
                                .foregroundColor(Color.gray)
                        }
                        Spacer()
                    }}
                )
                .contentShape(Rectangle())
                
            }
            switch albumListViewModel.state {
                case .empty:
                    EmptyView()
                case .good:
                    Color.clear
                        .onAppear(){
                            albumListViewModel.loadMore()
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

struct SearchAlbumView_Previews: PreviewProvider {
    static var previews: some View {
        SearchAlbumView(albumListViewModel: AlbumListViewModel.example())
    }
}
