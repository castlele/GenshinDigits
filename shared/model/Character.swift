//
//  Character.swift
//  GenshinDigits
//
//  Created by Nikita Semenov on 31.01.2022.
//

import Foundation

enum Vision: String {
    case pyro, cryo, electro, hydro, dendro, geo, anemo, adaptive
}

struct Character: Codable {
    let imageURL: String
    let name: String
    let rarity: String
    let weaponType: String
    let vision: String
    let sex: String
    let birthday: String
    let constellation: String
    let region: String
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case name, rarity
        case weaponType = "waeapon_type"
        case vision, sex, birthday, constellation, region
    }
    
    var imageName: String { name.lowercased() }
    var previewImageName: String { "preview_\(imageName)"}
    var visionColorNames: (light: String, dark: String)? {
        let visionName = vision.lowercased()
        
        guard visionName != Vision.adaptive.rawValue else {
            return nil
        }
        
        return ("vision-\(visionName)", "vision-\(visionName)-dark")
    }
}

extension Character: Identifiable {
    var id: String {
        name + sex + birthday
    }
}

extension Character: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

extension Character {
    static var dummyCharacter: Character {
        Character(imageURL: "eula", name: "Eula", rarity: "5", weaponType: "Claymore", vision: "Cryo", sex: "Female", birthday: "October 25th", constellation: "Aphros Delos", region: "Mondstadt")
    }
}
