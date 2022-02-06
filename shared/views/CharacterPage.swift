//
//  CharacterPage.swift
//  GenshinDigits
//
//  Created by Nikita Semenov on 30.01.2022.
//

import SwiftUI

struct CharacterPage: View {
    private var character: Character?
    
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                if let character = character {
                    Image(character.imageName)
                        .resizable()
                        .scaledToFit()
                    
                    HStack {
                        Text(character.name)
                        Text(character.rarity)
                        Text(character.weaponType)
                        Text(character.vision)
                    }
                    Text(character.sex)
                    Text(character.birthday)
                    Text(character.constellation)
                    Text(character.region)
                } else {
                    Group {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 2.5)
                            )
                            .frame(minWidth: 100, maxWidth: 200, minHeight: 150)
                        
                        Text("To see more info about certain character select it on the left panel.")
                            .frame(minWidth: 100, maxWidth: 200)
                    }
                }
                Spacer()
            }
        }
        .padding(.horizontal)
    }
    
    init(_ character: Character?) {
        self.character = character
    }
}

#if DEBUG
struct CharacterPage_Previews: PreviewProvider {
    static var previews: some View {
        CharacterPage(Character.dummyCharacter)
    }
}
#endif
