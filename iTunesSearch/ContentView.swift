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
    
    let urlString = "https://music.apple.com/tw/developer/%E5%8F%B0%E7%81%A3%E7%84%A1%E5%8D%B0%E8%89%AF%E5%93%81%E8%82%A1%E4%BB%BD%E6%9C%89%E9%99%90%E5%85%AC%E5%8F%B8/id1057896958?uo=4"
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
