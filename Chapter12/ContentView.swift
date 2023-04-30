//
//  ContentView.swift
//  Chapter12
//
//  Created by Mike Panitz on 4/18/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            Text("Item 1")
                .tabItem {
                    Image(systemName: "1.circle")
                    Text(" ")
                }
            Text("Item 2")
                .tabItem {
                    Image(systemName: "2.circle")
                    Text(" ")
                }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
