//
//  AlbumView.swift
//  iTunesSearch
//
//  Created by Jacky Ben on 2023/2/21.
//

import SwiftUI

struct AlbumView: View {
    @State var albumDetailViewModel: AlbumDetailViewModel
    @State var showSafari: Bool = false
    init (albumId: Int) {
            self.albumDetailViewModel = AlbumDetailViewModel(albumId: albumId)
    }
    var body: some View {
        switch (albumDetailViewModel.state) {
            case .empty:
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity)
            case .ready:
                VStack {
                    HStack {
                        HtmlUrlImageView(
                            urlString: albumDetailViewModel.album!.collectionViewURL!,
                            magnification: 1,
                            size: 120,
                            pictureHtmlIndex: 17
                        )
                        VStack(alignment: .leading) {
                            Text(albumDetailViewModel.album!.collectionName)
                                .font(.system(size:24))
//                                .lineLimit(2)
                            Text(albumDetailViewModel.album!.artistName)
                                .font(.system(size:20))
                                .foregroundColor(Color.gray)
                        }
                        
                        Spacer()
                    }
                    .padding(.leading, 5)
                    if (!albumDetailViewModel.songList.isEmpty) {
//                        Divider()
                        HStack {
                            Text("歌曲列表")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.leading, 5)
                        .padding(.top, 1)
                            
                        List {
                            ForEach (albumDetailViewModel.songList) { song in
                                NavigationLink(destination: SongView(song: song, shareUrl: URL(string: song.trackViewURL!))) {
                                    HStack (alignment: .center) {
                                        Text("\(song.trackNumber! + (song.discNumber!-1)*song.trackCount!)")
                                            .foregroundColor(Color.gray)
                                        Text(song.trackName)
                                            .lineLimit(1)
                                        Spacer()
                                        Text(
                                            String(
                                                format: "%d:%02d",
                                                song.trackTimeMillis/60000, //分鐘
                                                song.trackTimeMillis%60000/1000 //秒
                                            )
                                        )
                                    }
                                }
                            }
                        }
                        .listStyle(.plain)
                    }
                }
                .navigationTitle(albumDetailViewModel.album!.collectionName)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button{
                            showSafari.toggle()
                        } label: {
                            VStack {
                                Image(systemName: "music.note.tv")
                            }
                        }
                        ShareLink(item: albumDetailViewModel.album!.collectionViewURL!)
                    }
                }
                .fullScreenCover(isPresented: $showSafari) {
                    SafariView(url: URL(string: albumDetailViewModel.album!.collectionViewURL!)!)
                }
            case .error(let message):
                Text("ERROR: \(message)")
                    .foregroundColor(Color.red)
        }
        
    }
    
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView(albumId: 1281541439)
    }
}
