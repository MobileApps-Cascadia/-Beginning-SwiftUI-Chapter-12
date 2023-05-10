//
//  AlertActionSheetView.swift
//  Chapter12
//
//  Created by Mike Panitz on 4/30/23.
//

import SwiftUI

struct GameCharacter {
    var name : String
    var hp : Int
    var dmg : Int
}

struct GameView: View {
    
    @State var npcOrc = GameCharacter(name:"Orc", hp: 7, dmg: 3)
    @State var npcGoblin = GameCharacter(name:"Goblin", hp: 3, dmg: 2)
    @State var pcKnight = GameCharacter(name:"Sir Slays-A-Lot", hp: 9, dmg: 4)
    @State var pcMage = GameCharacter(name:"FizzleWhiz The Wizard", hp: 2, dmg: 4)
    var allChars : [Binding<GameCharacter>] {
        [$npcOrc, $npcGoblin, $pcKnight, $pcMage]
        
    }
    
    var body: some View {
        VStack {
            Text("Dungeon Brawl!")
                .font(.largeTitle)
            VStack {
                Spacer()
                CharacterView(char: $npcOrc, everyone: allChars)
                    
                CharacterView(char: $npcGoblin, everyone: allChars)
                Spacer()
            }
            Divider()
            VStack {
                Spacer()
                CharacterView(char: $pcKnight, everyone: allChars)
                CharacterView(char: $pcMage, everyone: allChars)
                Spacer()
                
            }
        }
    }
    
    struct CharacterView: View {
        @Binding var char: GameCharacter
        var everyone : [Binding<GameCharacter>]
        @State var attackAlert = false
        @State var showActionSheetMultipleButtons = false
        //@State var deathAlert = false
        @State private var victim: GameCharacter? = nil
        @State private var selectedTarget: GameCharacter? = nil
        
        var body: some View {
            VStack {
                Text(char.name)
                    .font(.title)
                HStack {
                    Text("HP: \(char.hp)")
                    Spacer()
                    Text("DMG: \(char.dmg)")
                }
            }
            .padding()
            .contextMenu(menuItems: {
                Button("Attack", action: {
                    // TODO: Show the 'who do you want to attack' actionsheet
                    showActionSheetMultipleButtons.toggle()
                })
                
                Button("Heal", action: {
                    withAnimation{
                        char.hp += 1
                    }
                    // This would be better with an attention-getting animation
                })
            })
            .actionSheet(isPresented: $showActionSheetMultipleButtons) {
                // .map will create an array, each of which is an ActionSheet.Button.x
                let buttons = everyone.map { character in
                    ActionSheet.Button.default(Text(character.wrappedValue.name)) {
                        // handle attack action
                        selectedTarget = character.wrappedValue
                        if(character.wrappedValue.hp > char.dmg){
                            
                            character.wrappedValue.hp -= char.dmg
                            attackAlert.toggle()
                        }
                        else{
                            character.wrappedValue.hp = 0
                            attackAlert.toggle()
                            //deathAlert.toggle()
                            
                        }
                   }
                }
                
                return ActionSheet(
                    title: Text("Targets:"),
                    message: Text("Who would you like \(char.name) to attack?"),
                    buttons: buttons
                    
                )
            }
            
                // TODO: Display the alert here, confirming that X attacked Y and did Z points of damage
            .alert(isPresented: $attackAlert){
                if(selectedTarget!.hp > char.dmg){
                    
                    
                    return Alert(title: Text("Attack has landed!"), message: Text("\(char.name) just attacked and dealt \(char.dmg) to \(selectedTarget!.name)!"), dismissButton: .default(Text("Bruh")))
                }
                else{
                    return Alert(title: Text("\(selectedTarget!.name) is at deaths door!"), message: Text(" \(selectedTarget!.name) was attacked for \(char.dmg) by \(char.name) and is almost dead! You should heal them to prevent their death!"), dismissButton: .default(Text("Oh God okay!")))
                }
            }
           /* .alert(isPresented: $deathAlert){
                
                Alert(title: Text("A Character is at deaths door!"), message: Text(" \(selectedTarget!.name) is almost dead!"), dismissButton: .default(Text("Oh God")))
            }*/
        }
    }
}



struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
