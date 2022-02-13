//
//  CharacterPage.swift
//  GenshinDigits
//
//  Created by Nikita Semenov on 30.01.2022.
//

import SwiftUI

// MARK: - Ascending Character Stats View
struct AscensingCharacterStatsView: View {
    private typealias Phase = Int
    private let columns = Array(repeating: GridItem(.flexible(minimum: 250/6, maximum: 250)), count: 6)
    @EnvironmentObject var characterVM: CharacterViewModel
    
    private var spetilaStatName: String {
        if let first = characterVM.currentStats?.first {
            return first.wrappedSpetialStatName
        }
        return "–"
    }
    
    private var ascensionMaterials: [Phase: AscensionMaterial] {
        characterVM.loadAscensionMaterials(byName: characterVM.selectedCharacter?.name ?? "")
    }
    
    private var header: some View {
        Group {
            Text("Ascension phase")
                .lineLimit(2)
            Text("Level")
                .lineLimit(2)
            Text("Base HP")
                .lineLimit(2)
            Text("Base ATK")
                .lineLimit(2)
            Text("Base DEF")
                .lineLimit(2)
            Text("Spetial Stat (\(spetilaStatName))")
                .lineLimit(3)
        }
    }
    
    var body: some View {
        if let _ = characterVM.currentStats {
            return AnyView(
                VStack(spacing: 0) {
                    LazyVGrid(columns: columns, spacing: 0) {
                        header
                    }
                        
                    ForEach(Stat.minAscensionPhase..<Stat.maxAscensionPhase) { phase in
                        LazyVGrid(columns: columns, spacing: 0) {
                            statRow(phase: phase)
                        }
                        setAscensingCostRow(phase)
                    }
                }
            )
        } else {
            return AnyView(EmptyView())
        }
    }
    
    private func statRow(phase: Int) -> some View {
        let (lower, upper) = characterVM.getStats(forPhase: phase)
        return Group {
            VStack {
                Text(String(phase))
            }
            
            ForEach(0..<5) { i in
                VStack {
                    getStatByColumn(i, stat: lower)
                    getStatByColumn(i, stat: upper)
                }
            }
        }
    }
    
    private func getStatByColumn(_ col: Int, stat: Stat) -> some View {
        var row = String()
        switch col {
            case 0: row = stat.level
            case 1: row = stat.baseHP
            case 2: row = stat.baseATK
            case 3: row = stat.baseDEF
            case 4: row = stat.spetialStatBonus
            default: break
        }
        return Text(row)
    }
    
    private func setAscensingCostRow(_ phase: Int) -> some View {
        VStack {
            setAscensingHeader(phase)
            setMaterialsImages(phase)
        }
    }
    
    private func setMaterialsImages(_ phase: Int) -> some View {
        guard let material = ascensionMaterials[phase + 1] else {
            fatalError("Where are my materials???")
        }
        return HStack {
            materialsPreview(material)
        }
    }
    
    private func setAscensingHeader(_ phase: Int) -> some View {
        let toPhase = phase + 1
        return HStack {
            Text("Ascending cost \(phase) -> \(toPhase)")
            Spacer()
        }
    }
    
    private func materialsPreview(_ material: AscensionMaterial) -> some View {
        ForEach(material.resources) { resource in
            VStack {
                Image(resource.imageName)
                    .resizable()
                    .scaledToFit()
                Text(resource.amount)
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

// MARK: - Character Page
struct CharacterPage: View {
    @EnvironmentObject var characterVM: CharacterViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center) {
                if let character = characterVM.selectedCharacter {
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
                    
                    AscensingCharacterStatsView()
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
                            .frame(minWidth: 100, maxWidth: 300, minHeight: 150)
                        
                        Text("To see more info about certain character select it on the left panel.")
                            .frame(minWidth: 100, maxWidth: 300)
                    }
                }
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}

#if DEBUG
struct CharacterPage_Previews: PreviewProvider {
    @StateObject static var characterVM = CharacterViewModel()
    static var previews: some View {
        CharacterPage()
            .environmentObject(characterVM)
        
        CharacterPage()
            .environmentObject(characterVM)
            .onAppear {
                characterVM.selectedCharacter = Character.dummyCharacter
                characterVM.setCurrentStats()
            }
    }
}
#endif
