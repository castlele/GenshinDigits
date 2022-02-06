//
//  CharacterViewModel.swift
//  GenshinDigits
//
//  Created by Nikita Semenov on 31.01.2022.
//

import SwiftUI

final class CharacterViewModel: ObservableObject {
    private let bundle = Bundle.main
    private(set) var characters: [String: Character] = [:]
    
    @Published var characterNames: [String] = []
    @Published var selectedCharacter: Character? = nil
    
    var visionColorsOfCurrentCharacter: [Color] {
        if let selectedCharacter = selectedCharacter {
            if let (light, dark) = selectedCharacter.visionColorNames {
                #if os(macOS)
                let defaultBackgroundColor = Color(nsColor: NSColor.windowBackgroundColor)
                #else
                let defaultBackgroundColor = Color(uiColor: UIColor.systemBackground)
                #endif
                return [Color(dark), Color(light), defaultBackgroundColor]
            }
        }
        return [.clear]
    }
    
    func loadCharacters() {
        if let url = self.bundle.url(forResource: "bio", withExtension: "json") {
            let _characters = getCharacters(fromURL: url)
            let names = makeCharactersDict(_characters)
            characterNames = names
        }
    }
    
    private func getCharacters(fromURL url: URL) -> [Character] {
        do {
            let jsonData = try getContentsOfFile(atPath: url)
            let characters: [Character] = try decodeData(jsonData)
            return characters
        } catch is DecodingError {
            fatalError(DecodingFatalError.decodingError.rawValue, file: "CharacterViewModel.swift", line: 42)
        } catch {
            fatalError(DecodingFatalError.invalidURL.rawValue, file: "CharacterViewModel.swift", line: 41)
        }
    }
    
    @discardableResult
    private func makeCharactersDict(_ charactersList: [Character]) -> [String] {
        var names: [String] = []
        charactersList.forEach { character in
            let name = character.imageName
            names.append(name)
            self.characters[name] = character
        }
        return names
    }
    
    func getCharacter(byName name: String) -> Character? {
         return characters[name]
    }
    
    func getAllCharacters() -> [Character] {
        return characters.values.map { $0 }.sorted(by: { $0.name < $1.name })
    }
}
