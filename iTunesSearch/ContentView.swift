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
    
    var body: some View {
        SearchListView()
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
