// Modified game.swift
//  AlertActionSheetView.swift
//  Chapter12
//
//  Created by Mike Panitz on 4/30/23.
//

import SwiftUI

struct GameCharacter: Identifiable {
    var id = UUID() // Add an identifier for conformance
    var name : String
    var hp : Int
    var dmg : Int
}

struct GameView: View {
    //@State private var isAttackSuccessVisible = false
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
       // @Binding var isAttackSuccessVisible: Bool
        @Binding var char: GameCharacter
        var everyone : [Binding<GameCharacter>]
        @State private var isActionSheetPresented = false
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
                    isActionSheetPresented = true //Show the action sheeet
                    //  Show the 'who do you want to attack' actionsheet
                    //victim = char
                })
                
                Button("Heal", action: {
                    withAnimation(.spring()) {
                        char.hp += 1
                    }
                })
            })
            .actionSheet(isPresented: $isActionSheetPresented) {
                
                let buttons = everyone.map{
                    character in ActionSheet.Button.default(Text(character.wrappedValue.name)){
                        character.wrappedValue.hp -= char.dmg
                        
                        //  handle attack action
                    }
                }
                
                
                
                return ActionSheet(
                    title: Text("Targets:"),
                    message: Text("Who would you like \(char.name) to attack?"),
                    buttons: buttons
                )
            }
            //  Display the alert here, confirming that X attacked Y and did Z points of damage
            
            .alert(item: $victim) { victim in
                let damage = char.dmg
                return Alert(
                    title: Text("\(char.name) attacked \(victim.name)"),
                    message: Text("\(char.name) did \(damage) points of damage to \(victim.name)!"),
                    primaryButton: .default(Text("OK")) {
                       // isAttackSuccessVisible = true // Show attack success message
                    },
                    secondaryButton: .cancel()
                    // Handle alert dismissal if needed
                    
                )
            }
            
        }
    }
    
    
    
    
    struct GameView_Previews: PreviewProvider {
        static var previews: some View {
            GameView()
        }
    }
}

