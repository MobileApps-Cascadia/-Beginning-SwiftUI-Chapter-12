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
        @State private var showingAttackSheet = false
        @State private var showingAlert = false
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
                    showingAttackSheet = true
                })
                
                Button("Heal", action: {
                    withAnimation {
                        char.hp += 1
                    }
                })
            })
            .actionSheet(isPresented: $showingAttackSheet) {
                // .map will create an array, each of which is an ActionSheet.Button.x
                let buttons = everyone.map { character in
                    ActionSheet.Button.default(Text(character.wrappedValue.name)) {
                        // handle attack action
                        if char.hp > 0 && character.wrappedValue.hp > 0 {
                            selectedTarget = character.wrappedValue
                            character.wrappedValue.hp -= char.dmg
                            showingAlert = true
                        }
                    }
                }
                
                return ActionSheet(
                    title: Text("Targets:"),
                    message: Text("Who would you like \(char.name) to attack?"),
                    buttons: buttons
                )
            }
            .alert(isPresented: $showingAlert) {
                if var victim = selectedTarget { // Change let to var
                    let damage = char.dmg
                    victim.hp -= damage
                    let message = "\(char.name) attacked \(victim.name) and inflicted \(damage) points of damage, leaving \(max(0, victim.hp)) HP left"
                    return Alert(title: Text("Attack Result"), message: Text(message), dismissButton: .default(Text("OK")))
                } else {
                    return Alert(title: Text("Attack Result"), message: Text("No target selected"), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
