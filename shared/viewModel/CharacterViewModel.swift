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
    private(set) var characterStats: [String: [Stat]] = [:]
    
    @Published var characterNames: [String] = []
    @Published var selectedCharacter: Character? = nil
    @Published var currentStats: [Stat]? = nil
    
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
    
    @discardableResult
    func loadCharacterStats(byName name: String) -> [Stat]? {
        let fileName = "stats_\(name.lowercased().replacingOccurrences(of: " ", with: "_"))"
        if let url = self.bundle.url(forResource: fileName, withExtension: "json") {
            let _stats = getStats(fromURL: url)
            characterStats[name] = _stats
            return _stats
        }
        return nil
    }
    
    func loadAscensionMaterials(byName name: String) {
        
    }
    
    private func getCharacters(fromURL url: URL) -> [Character] {
        checkDecodingForErrors {
            let jsonData = try getContentsOfFile(atPath: url)
            let characters: [Character] = try decodeData(jsonData)
            return characters
        }
    }
    
    private func getStats(fromURL url: URL) -> [Stat] {
        checkDecodingForErrors {
            let jsonData = try getContentsOfFile(atPath: url)
            let stats: [Stat] = try decodeData(jsonData)
            return stats
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
    
    func setCurrentStats(_ name: String? = nil) {
        let _name = (name != nil) ? name : (selectedCharacter == nil) ? nil : selectedCharacter?.name
        
        if let name = _name {
            if let _stats = characterStats[name] {
                currentStats = _stats
            }
            currentStats = loadCharacterStats(byName: name)
        }
    }
    
    func getStats(forPhase phase: Int) -> (lower: Stat, upper: Stat) {
        guard phase >= 0 && phase <= 6 else {
            fatalError("Ascension phase should be between 0 and 6, but it is equal to \(phase)")
        }
        guard let stats = currentStats else {
            fatalError("Application uses stats data while it is nil")
        }
        
        let lower = stats.first { $0.ascensionPhase == "\(phase)_l" }!
        let upper = stats.first { $0.ascensionPhase == "\(phase)_u" }!
        
        return (lower, upper)
    }
}
