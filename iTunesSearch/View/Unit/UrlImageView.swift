//
//  UrlImageView.swift
//  iTunesSearch
//
//  Created by Jacky Ben on 2023/2/4.
//

import SwiftUI

struct UrlImageView: View {
    
    let urlString: String
    
    @State var data: Data?
    @State var size: CGFloat = 60
    @State var cornerRadius: CGFloat = 10
    @State var customImage: Bool = false
    @State var imageName: String = "music.mic.circle"
    
    var body: some View {
        if let data = data, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .background(Color.gray)
                .cornerRadius(cornerRadius)
        } else {
            if customImage {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size, height: size)
                    .cornerRadius(size/2)
                    .onAppear {
                        getData()
                    }
            } else {
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size, height: size)
                    .cornerRadius(size/2)
                    .onAppear {
                        getData()
                    }
            }
        }
    }
    
    private func getData() {
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            if let error = error {
                print("URLSession error: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.data = data
                }
            }
        }.resume()
    }
}

struct UrlImageView_Previews: PreviewProvider {
    static var previews: some View {
        let urlString = "https://is4-ssl.mzstatic.com/image/thumb/Music125/v4/44/26/cc/4426cc53-3242-a46b-facf-c1b5716e4812/00050087152055.rgb.jpg/100x100bb.jpg"
        UrlImageView(urlString: urlString)
    }
}
