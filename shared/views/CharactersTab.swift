//
//  CharactersTab.swift
//  GenshinDigits (macOS)
//
//  Created by Nikita Semenov on 29.01.2022.
//

import SwiftUI

struct CharactersTab: View {
    private let columns = [GridItem(.adaptive(minimum: 100))]
    
    @EnvironmentObject var characterViewModel: CharacterViewModel
    
    var body: some View {
        HStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(characterViewModel.getAllCharacters()) { character in
                        CharacterPreviewCard(character: character)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(
                                        (character == characterViewModel.selectedCharacter
                                        ? Color.accentColor
                                        : Color.black)
                                        , lineWidth: 1.5
                                    )
                            )
                            .padding(.horizontal)
                            .onTapGesture {
                                characterViewModel.selectedCharacter = character
                            }
                    }
                }
                .padding(.horizontal)
            }
            .frame(minWidth: 200, maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            Divider()
            
            CharacterPage(characterViewModel.selectedCharacter)
                .background(
                    LinearGradient(colors: characterViewModel.visionColorsOfCurrentCharacter,
                                   startPoint: .bottom, endPoint: .top)
                )
                .frame(minWidth: 150, maxWidth: 350)
            
        }
        .onDisappear { characterViewModel.selectedCharacter = nil }
    }
}

#if DEBUG
struct CharactersTab_Previews: PreviewProvider {
    static var previews: some View {
        CharactersTab()
    }
}
#endif
