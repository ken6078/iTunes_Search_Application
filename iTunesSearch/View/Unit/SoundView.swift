//
//  SoundView.swift
//  iTunesSearch
//
//  Created by Jacky Ben on 2023/2/15.
//

import SwiftUI

struct SoundView: View {
    var urlString: String
    @State var playing: Bool = false
    @StateObject private var soundManager = SoundManager()
    var body: some View {
            Image(systemName: playing ? "pause.circle.fill": "play.circle.fill")
                .onTapGesture {
                    soundManager.playSound(sound: urlString)
                    if (playing) {
                        soundManager.queuePlayer?.pause()
                    } else {
                        soundManager.queuePlayer?.play()
                    }
                    playing.toggle()
                    
                }
    }
}

struct SoundView_Previews: PreviewProvider {
    static var previews: some View {
        SoundView(urlString: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/09/56/a3/0956a3ba-1d87-1297-eaa2-6520a9297375/mzaf_9451698682107745612.plus.aac.p.m4a")
    }
}
