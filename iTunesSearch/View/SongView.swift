//
//  SongView.swift
//  iTunesSearch
//
//  Created by Jacky Ben on 2023/2/14.
//

import SwiftUI

struct SongView: View {
    @State var song: Song
    @State var shareUrl: URL?
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
            HStack{
                Text(song.trackName)
                    .font(.system(size:36))
                Button(action: shareButton) {
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 36)
                        .foregroundColor(Color("DefultForegrondColor"))
                }
            }
            Spacer()
            Text(song.artistName)
                .onAppear()
            Spacer(minLength: 60)
            HStack {
                Text("預覽: ")
                    .font(.system(size:36))
                SoundView(urlString: song.previewURL)
            }
        }
            .padding(.leading, 30)
            .padding(.trailing, 30)
            .padding(.bottom, 40)
            .padding(.top)
            .frame(maxHeight: 300)
        
        .navigationTitle(song.trackName)
    }
    
    func shareButton() {
            let url = shareUrl
            let activityController = UIActivityViewController(activityItems: [url!], applicationActivities: nil)

            UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
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
