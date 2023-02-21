//
//  ArtistView.swift
//  iTunesSearch
//
//  Created by Jacky Ben on 2023/2/21.
//

import SwiftUI

struct ArtistView: View {
    @State var artistdetailViewModel: ArtistDetailViewModel
    @State var showSafari: Bool = false
    init(artistId: Int) {
        self.artistdetailViewModel = ArtistDetailViewModel(artistId: artistId)
    }
    var body: some View {
        switch (artistdetailViewModel.state) {
            case .empty:
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity)
            case .ready:
                VStack {
                    HStack {
                        HtmlUrlImageView(
                            urlString: artistdetailViewModel.artist!.artistLinkURL,
                            magnification: 1.5,
                            size: 80,
                            pictureHtmlIndex: 16
                        )
                        Text(artistdetailViewModel.artist!.artistName)
                            .font(.system(size:40))
                        Spacer()
                    }
                    .padding(.leading, 5)
                    if (!artistdetailViewModel.albumList.isEmpty) {
//                        Divider()
                        HStack {
                            Text("最新發行專輯")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.leading, 5)
                        .padding(.top, 1)
                            
                        List {
                            ForEach (artistdetailViewModel.albumList) { album in
                                NavigationLink(destination: AlbumView(albumId: album.id)) {
                                    HStack (alignment: .center) {
                                        UrlImageView(
                                            urlString: album.artworkUrl100,
                                            size: 75
                                        )
                                        VStack (alignment: .leading) {
                                            Text(album.collectionName)
                                            Text(album.releaseDate.prefix(10))
                                                .foregroundColor(Color.gray)
                                        }
                                    }
                                }
                            }
                        }
                        .listStyle(.plain)
                    }
                }
                .navigationTitle(artistdetailViewModel.artist!.artistName)
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
                        ShareLink(item: artistdetailViewModel.artist!.artistLinkURL)
                    }
                }
                .fullScreenCover(isPresented: $showSafari) {
                    SafariView(url: URL(string: artistdetailViewModel.artist!.artistLinkURL)!)
                }
            case .error(let message):
                Text("ERROR\(message)")
        }
        
    }
}

struct ArtistView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistView(artistId: 370412270)
    }
}
