//
//  Stat.swift
//  GenshinDigits
//
//  Created by Nikita Semenov on 06.02.2022.
//

import Foundation

struct Stat: Codable {
    static let minAscensionPhase = 0
    static let maxAscensionPhase = 6
    
    let ascensionPhase: String
    let level: String
    let baseHP: String
    let baseATK: String
    let baseDEF: String
    let spetialStatName: String
    let spetialStatBonus: String
    
    enum CodingKeys: String, CodingKey {
        case ascensionPhase = "ascension_phase"
        case level
        case baseHP = "base_hp"
        case baseATK = "base_atk"
        case baseDEF = "base_def"
        case spetialStatName = "spetial_stat_name"
        case spetialStatBonus = "spetial_stat_bonus"
    }
    
    var wrappedSpetialStatName: String {
        let words = spetialStatName.split(separator: "_")
        return words.filter { $0 != "bonus" }.joined(separator: " ").capitalized
    }
}

extension Stat: Identifiable {
    var id: String {
        level + baseHP + baseATK
    }
}

extension Stat: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(baseHP + baseATK)
    }
}

extension Stat {
    static var dummyStats: [Stat] {
        [
            Stat(
                ascensionPhase: "0_l",
                level: "1/20",
                baseHP: "1030",
                baseATK: "27",
                baseDEF: "59",
                spetialStatName: "crit_dmg",
                spetialStatBonus: "\\u2014"
            ),
            Stat(
                ascensionPhase: "0_u",
                level: "20/20",
                baseHP: "2671",
                baseATK: "69",
                baseDEF: "152",
                spetialStatName: "crit_dmg",
                spetialStatBonus: "\\u2014"
            )
        ]
    }
}
