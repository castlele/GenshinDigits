//
//  Image+Extension.swift
//  GenshinDigits (iOS)
//
//  Created by Nikita Semenov on 03.02.2022.
//

import SwiftUI

extension Image {
    private var assetImageNames: [String] {
        ["feather-sidebar", "sword-sidebar"]
    }
    init(imageName name: String) {
        self.init("")
        if assetImageNames.contains(name) {
            self = Image(name)
        } else {
            self = Image(systemName: name)
        }
    }
}
