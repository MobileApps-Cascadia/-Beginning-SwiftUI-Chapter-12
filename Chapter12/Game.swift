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
        

        @State private var victim: GameCharacter? = nil
        
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
                })
                
                Button("Heal", action: {
                    char.hp += 1
                    // This would be better with an attention-getting animation
                })
            })
//            .actionSheet(isPresented: /* TODO: FILL THIS IN */) {
//                // .map will create an array, each of which is an ActionSheet.Button.x
//                let buttons = everyone.map { character in
//                    ActionSheet.Button.default(Text(character.wrappedValue.name)) {
//                        // handle attack action
//                        character.wrappedValue.hp -= char.dmg
//                    }
//                }
//                
//                return ActionSheet(
//                    title: Text("Targets:"),
//                    message: Text("Who would you like \(char.name) to attack?"),
//                    buttons: buttons
//                )
//            }
                // TODO: Display the alert here, confirming that X attacked Y and did Z points of damage
        }
    }
}



struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
