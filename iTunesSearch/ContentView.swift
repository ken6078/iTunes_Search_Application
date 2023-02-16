//
//  ContentView.swift
//  iTunesSearch
//
//  Created by Jacky Ben on 2023/2/3.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color("DefultBackgrondColor"))
    }
    @State var shouldShowTabBar = false
    
    let urlString = "https://music.apple.com/tw/album/%E8%AA%AA%E5%A5%BD%E4%B8%8D%E5%93%AD/1632190508?i=1632190512"
    var body: some View {
        TabView{
            HomePage().tabItem {
                NavigationLink(destination: HomePage()){
                    Image(systemName: "house")
                    Text("首頁")
                }
            }
            
            SearchListView().tabItem {
                NavigationLink(destination: SearchListView()){
                    Image(systemName: "magnifyingglass")
                    Text("搜尋")
                }
            }
        }
    }
}

struct HomePage: View {
    @State var searchText = ""
    var body: some View{
        NavigationView{
            Text("Home Page")
        }
    }
}

struct SearchPage: View{
    @State var searchText = ""
    var body: some View{
        NavigationView{
            Text("Searching Page")
            .navigationBarTitle("搜尋歌曲、歌手")
        }
        .searchable(text: $searchText)
    }
}

struct TestPage: View {
    @State var searchText = ""
    var body: some View{
        NavigationView{
            Text("Test Page")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
