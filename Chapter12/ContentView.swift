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
            AlertActionSheetView()
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Alerts")
                }
            ContextMenuView()
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Context Menus")
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


