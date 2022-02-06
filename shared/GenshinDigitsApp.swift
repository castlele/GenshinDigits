//
//  GenshinDigitsApp.swift
//  Shared
//
//  Created by Nikita Semenov on 29.01.2022.
//

import SwiftUI

@main
struct GenshinDigitsApp: App {
    @StateObject var characterViewModel = CharacterViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environmentObject(characterViewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear {
                    characterViewModel.loadCharacters()
                }
        }
    }
}
