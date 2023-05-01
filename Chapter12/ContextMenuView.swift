//
//  AlertActionSheetView.swift
//  Chapter12
//
//  Created by Mike Panitz on 4/30/23.
//

import SwiftUI

struct ContextMenuView: View {
    @State var myColor = Color.black
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(myColor)
            Text("Click and hold to select a color")
                .padding()
                .background(.white)
                .foregroundColor(myColor)
                .cornerRadius(30)
                .contextMenu(menuItems: {
                    Button("Red", action: {
                        myColor = Color.red
                    })
                    Button("Purple", action: purple)
                    Button("Green", action: green)
                    Button("Orange", action: orange)
                })
        }
        .background(myColor)
    }
    func purple() {
        myColor = Color.purple
    }
    func green() {
        myColor = Color.green
    }
    func orange() {
        myColor = Color.orange
    }
}

struct ContextMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenuView()
    }
}
