//
//  AscentionMaterial.swift
//  GenshinDigits
//
//  Created by Nikita Semenov on 13.02.2022.
//

import Foundation

extension String {
    func makeFileName() -> String {
        self
            .lowercased()
            .replacingOccurrences(of: " ", with: "_")
            .replacingOccurrences(of: "'", with: "")
    }
}

struct Resource: Identifiable {
    let name: String
    let amount: String
    let imageName: String
    
    init(_ material: (name: String, amount: String, imageName: String)) {
        self.name = material.name
        self.amount = material.amount
        self.imageName = material.imageName
    }
    
    var id: String {
        name + amount + imageName
    }
}

struct AscensionMaterial: Codable {
    let level: String
    let material_1_title: String
    let material_1_cost: String
    let material_2_title: String
    let material_2_cost: String
    let material_3_title: String
    let material_3_cost: String
    let material_4_title: String
    let material_4_cost: String
    let material_5_title: String?
    let material_5_cost: String?
    
    enum CodingKeys: String, CodingKey {
        case level = "lvl"
        case material_1_title, material_1_cost, material_2_title
        case material_2_cost, material_3_title, material_3_cost
        case material_4_title, material_4_cost, material_5_title
        case material_5_cost
    }
    
    var resources: [Resource] {
        let first = (material_1_title, material_1_cost, material_1_title.makeFileName())
        let second = (material_2_title, material_2_cost, material_2_title.makeFileName())
        let third = (material_3_title, material_3_cost, material_3_title.makeFileName())
        let fourth = (material_4_title, material_4_cost, material_4_title.makeFileName())
        var resources = [Resource(first), Resource(second), Resource(third), Resource(fourth)]
        
        if let material_5_cost = material_5_cost, let material_5_title = material_5_title {
            let fifth = (material_5_title, material_5_cost, material_5_title.makeFileName())
            resources.append(Resource(fifth))
        }
        return resources
    }
}
