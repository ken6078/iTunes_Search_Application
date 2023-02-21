//
//  SongView.swift
//  iTunesSearch
//
//  Created by Jacky Ben on 2023/2/14.
//

import SwiftUI
import SafariServices

struct SongView: View {
    @State var song: Song
    @State var shareUrl: URL?
    @State var showSafari: Bool = false
    var body: some View {
        VStack {
            HtmlUrlImageView(
                urlString: song.collectionViewURL,
                magnification: 1.5,
                size: 200,
                pictureHtmlIndex: 17,
                customImage: true,
                imageName: "CD"
            )
            Spacer(minLength: 80)
                Text(song.trackName)
                    .font(.system(size:36))
            Spacer()
            Text(song.artistName)
                .font(.system(size:28))
                .onAppear()
            Spacer()
            Text("專輯：\(song.collectionName)")
                .fixedSize()
                .onAppear()
            Spacer()
            Text(song.releaseDate.prefix(10))
                .font(.system(size:28))
        }
            .padding(.leading, 30)
            .padding(.trailing, 30)
            .padding(.bottom, 40)
            .frame(maxHeight: 300)
        .navigationTitle(song.trackName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ShareLink(item: shareUrl!)
            }
            
            ToolbarItemGroup(placement: .bottomBar) {
                Button{}label: {
                    VStack {
                        SoundView(urlString: song.previewURL)
                        Text("預覽")
                    }
                }
                Spacer()
                NavigationLink(destination: AlbumView(albumId: song.collectionId)){
                    VStack {
                        Image(systemName: "mic.fill")
                        Text("專輯")
                    }
                }
                Spacer()
                NavigationLink(destination: ArtistView(artistId: song.artistID)) {
                    VStack {
                        Image(systemName: "person.fill")
                        Text("歌手")
                    }
                }
                Spacer()
                Button{
                    showSafari.toggle()
                } label: {
                    VStack {
                        Image(systemName: "music.note.tv.fill")
                        Text("網頁版")
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showSafari) {
            SafariView(url: shareUrl!)
        }
    }
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
        SongView(
            song: Song.example(),
            shareUrl: URL(string: "https://music.apple.com/tw/album/%E8%AA%AA%E5%A5%BD%E4%B8%8D%E5%93%AD/1480229674?i=1480229675&uo=4")!
        )
    }
}
