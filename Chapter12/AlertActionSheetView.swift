//
//  AlertActionSheetView.swift
//  Chapter12
//
//  Created by Mike Panitz on 4/30/23.
//

import SwiftUI

struct AlertActionSheetView: View {
    
    @State var showAlert = false
    @State var showActionSheet = false
    
    @State var showAlertMultipleButtons = false
    @State var showActionSheetMultipleButtons = false
    
    @State var respondToButtonInAlert = false
    @State var message = "No message yet"
    
    @State var respondToButtonInActionSheet = false
    @State var messageAS = "No message yet (from ActionSheet)"
    
    var body: some View {
        VStack {
            Button("Show Alert") {
                showAlert.toggle()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Warning!"),
                      message: Text("Zombies on the loose"),
                      dismissButton: .default(Text("OK")))
            }
            .padding()
            
            Button("Show ActionSheet") {
                showActionSheet.toggle()
            }
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text("Warning!"),
                            message: Text("Zombies on the loose"), buttons: [.default(Text("OK"))])
            }
            
            Button("Show Alert (two buttons)") {
                showAlertMultipleButtons.toggle()
            }
            .padding()
            .alert(isPresented: $showAlertMultipleButtons) {
                Alert(title: Text("Warning!"),
                      message: Text("Zombies on the loose"),
                      primaryButton: .default(Text("Default")),
                      secondaryButton: .cancel(Text("Cancel")))
            }
            
            Button("Show ActionSheet (mutliple buttons)") {
                showActionSheetMultipleButtons.toggle()
            }
            .padding()
            .actionSheet(isPresented: $showActionSheetMultipleButtons) {
                ActionSheet(title: Text("Warning!"),
                            message: Text("Zombies on the loose"),
                            buttons: [
                                .default(Text("Default")),
                                .cancel(Text("Cancel")),
                                .destructive(Text("Destructive")),
                                .destructive(Text("Destructive 2")),
                                .destructive(Text("Destructive 3")),
                                .destructive(Text("Destructive 4")),
                                .default(Text("Default 2")),
                                .default(Text("Default 3")),
                                .default(Text("Default 4")),
                                .default(Text("Default 5")),
                                .default(Text("Default 6")),])
            }
            
            Button("Code that responds to the button press") {
                respondToButtonInAlert.toggle()
            }
            .padding(.top)
            .alert(isPresented: $respondToButtonInAlert) {
                Alert(title: Text("Warning!"),
                      message: Text("Zombies on the loose"),
                      primaryButton: .default(Text("Default"), action: {
                    message = "Default chosen"
                }),
                      secondaryButton: .cancel(Text("Cancel"), action: cancelFunction))
            }
            
            Text(message)
            
            Button("Show ActionSheet (mutliple buttons)") {
                respondToButtonInActionSheet.toggle()
            }
            .padding(.top)
            .actionSheet(isPresented: $respondToButtonInActionSheet) {
                ActionSheet(title: Text("Warning!"),
                            message: Text("Zombies on the loose"),
                            buttons: [
                                .default(Text("Default"), action: {
                                    messageAS = "Default chosen"
                                }),
                                .cancel(Text("Cancel"), action: {
                                    messageAS = "Cancel chosen"
                                }),
                                .destructive(Text("Destructive"), action: {
                                    messageAS = "Destructive chosen"
                                }),
                                .destructive(Text("Destructive 2"), action: {
                                    messageAS = "Destructive 2 chosen"
                                }),
                                .destructive(Text("Destructive 3"), action: {
                                    messageAS = "Destructive 3 chosen"
                                }),
                                .destructive(Text("Destructive 4"), action: {
                                    messageAS = "Destructive 4 chosen"
                                }),
                                .default(Text("Default 2"), action: {
                                    messageAS = "Default 2 chosen"
                                }),
                                .default(Text("Default 3"), action: {
                                    messageAS = "Default 3 chosen"
                                }),
                                .default(Text("Default 4"), action: {
                                    messageAS = "Default 4 chosen"
                                }),
                                .default(Text("Default 5"), action: {
                                    messageAS = "Default 5 chosen"
                                }),
                                .default(Text("Default 6"), action: {
                                    messageAS = "Default 6 chosen"
                                })])
            }
            Text(messageAS)
        }
    }
    func cancelFunction() {
        message = "Cancel chosen"
    }
}

struct AlertActionSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AlertActionSheetView()
    }
}
