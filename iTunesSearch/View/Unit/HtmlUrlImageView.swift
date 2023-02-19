//
//  HtmlUrlImageView.swift
//  iTunesSearch
//
//  Created by Jacky Ben on 2023/2/13.
//

import SwiftUI
import Kanna

struct HtmlUrlImageView: View {
    
    let urlString: String
    
    @State var uiImage: UIImage?
    @State var magnification: Double = 1
    @State var size: CGFloat = 60
    // SongImage: 16, AlbumImage: 17
    @State var pictureHtmlIndex: Int
    @State var customImage: Bool = false
    @State var imageName: String = "person.crop.circle"
    
    var body: some View {
        if let uiImage = uiImage {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .background(Color.gray)
                .cornerRadius(size/2)
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
        //從網頁中獲取歌手圖片位置
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data, let html = String(data: data, encoding: .utf8) {
                if let doc = try? HTML(html: html, encoding: .utf8) {
                    // 以css找特定item
                    if (doc.css("meta").count < pictureHtmlIndex) {
                        print("HTML parser error")
                        return
                    }
                    guard let imageURL = URL(string: String(doc.css("meta")[pictureHtmlIndex]["content"]!)) else {return}
                    URLSession.shared.dataTask(with: imageURL) {data, response, error in
                        if let error = error {
                            print("URLSession error: \(error)")
                        } else {
                            DispatchQueue.main.async {
                                self.uiImage = UIImage(data: data!)
                                if (magnification != 1) {
                                    cropImage()
                                }
                            }
                        }
                    }.resume()
                    
                } else {
                    print("HTML parser error")
                }
            }
        }.resume()
    }
    
    private func cropImage() {
        if self.uiImage != nil {
            let sourceImage = self.uiImage!

            // The shortest side
            let sideLength = min(
                sourceImage.size.width,
                sourceImage.size.height
            ) / magnification

            // Determines the x,y coordinate of a centered
            // sideLength by sideLength square
            let sourceSize = sourceImage.size
            let xOffset = (sourceSize.width - sideLength) / 2.0
            let yOffset = (sourceSize.height - sideLength) / 2.0

            // The cropRect is the rect of the image to keep,
            // in this case centered
            let cropRect = CGRect(
                x: xOffset,
                y: yOffset,
                width: sideLength,
                height: sideLength
            ).integral

            // Center crop the image
            let sourceCGImage = sourceImage.cgImage!
            let croppedCGImage = sourceCGImage.cropping(
                to: cropRect
            )!
            DispatchQueue.main.async {
                self.uiImage = UIImage(cgImage: croppedCGImage)
            }
        }
    }
}

struct HtmlUrlImageView_Previews: PreviewProvider {
    static var previews: some View {
        let urlString = "https://music.apple.com/tw/artist/%E4%BA%94%E6%9C%88%E5%A4%A9/369211611?uo=4"
        HtmlUrlImageView(urlString: urlString, pictureHtmlIndex: 16)
    }
}
