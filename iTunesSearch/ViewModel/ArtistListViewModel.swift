//
//  ArtistListViewModel.swift
//  iTunesSearch
//
//  Created by Jacky Ben on 2023/2/13.
//

import Foundation
import Combine

class ArtistListViewModel: ObservableObject{
    
    enum State: Comparable {
        case empty
        case good
        case isLoading
        case loadedAll
        case error(String)
    }
    
    @Published var searchText: String = ""
    @Published var artists: [Artist] = [Artist]()
    @Published var state: State = .good{
        didSet{
            print("state chenged to: \(state)")
        }
    }
    
    let limit: Int = 20
    var page: Int = 0
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        $searchText
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink{[weak self] text in
                self?.state = .good
                self?.artists = []
                self?.page = 0
                self?.getArtistList(for: text)
            }.store(in: &subscriptions)
        
    }
    
    func loadMore(){
        print("Load More For: \(self.searchText) @ Page: \(self.page)")
        getArtistList(for: searchText)
    }
    
    func getArtistList(for searchText: String) {
        
        guard !searchText.isEmpty else {
            self.state = .empty
            return
        }
        guard self.state == State.good else {return}
        
        let offset = limit * page
        let urlText = String(format: "https://itunes.apple.com/search?country=tw&media=music&term=\(searchText)&explicit=Yes&limit=\(self.limit)&offset=\(offset)&entity=allArtist")
        guard let encondeUrlText = urlText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        guard let url = URL(string: encondeUrlText) else {return}
        
        print("Get Data for: \(searchText)")
        state = .isLoading
        
        URLSession.shared.dataTask(with: url){[weak self] data, response, error in
            if let error = error {
                print("URLSession error: \(error)")
                DispatchQueue.main.async {
                    self?.state = .error("Could not load: \(error.localizedDescription)")
                }
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(ArtistResult.self, from: data)
                    DispatchQueue.main.async {
                        for artist in result.results {
                            self?.artists.append(artist)
                        }
                    }
                    self?.page += 1
                    DispatchQueue.main.async {
                        self?.state = (result.results.count == self?.limit) ? .good : .loadedAll
                    }
                    print("fetched \(result.resultCount)")
                } catch {
                    print("ArtistResult Json Decode error: \(error)")
//                    let str = String(decoding: data, as: UTF8.self)
//                    print("Json Decode error by Url:\(encondeUrlText)")
//                    print(encondeUrlText)
                    DispatchQueue.main.async {
                        self?.state = .error("Json Decode error: \(error.localizedDescription)")
                    }
                }
            }
        }.resume()
    }
    
    static func example() -> ArtistListViewModel {
        let vm = ArtistListViewModel()
        vm.searchText = "Mayday"
        return vm
    }
}
