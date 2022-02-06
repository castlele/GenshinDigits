//
//  CharacterPreviewCard.swift
//  GenshinDigits (macOS)
//
//  Created by Nikita Semenov on 30.01.2022.
//

import SwiftUI

struct CharacterPreviewCard: View {
    let character: Character
    
    @State private var isHovered: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Image(character.previewImageName)
                .resizable()
                .scaledToFill()
                .selectableAsRectangle(isHovered, selection: [.accentColor.opacity(0.3), .clear])
               
            Text(character.name)
                .font(.caption)
                .lineLimit(2)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray)

        }
        .frame(width: 100, height: 125)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .onHover { isHovered in
            self.isHovered = isHovered
        }
    }
}

#if DEBUG
struct CharacterPreviewCard_Previews: PreviewProvider {
    static var previews: some View {
        CharacterPreviewCard(character: Character.dummyCharacter)
    }
}
#endif
