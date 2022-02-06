//
//  SidebarViewModel.swift
//  GenshinDigits (iOS)
//
//  Created by Nikita Semenov on 03.02.2022.
//

import SwiftUI

final class SidebarViewModel: ObservableObject {
    @Published var currentTab = 0
    @Published var hoveredTab = -1
    
    func sidebarButtonStroke(tab: Int) -> Color {
        currentTab == tab ? Color.accentColor : Color.black
        
    }
    
    func selectTab(_ tab: Int) {
        currentTab = tab
    }
    
    func isHovering(_ isHover: Bool, currentTab tab: Int) {
        hoveredTab = isHover ? tab : -1
    }
    
    func getImageForButton(_ i: Int) -> String {
        switch i {
            case 0:
                return "house"
            case 1:
                return "person"
            case 2:
                return "feather-sidebar"
            case 3:
                return "sword-sidebar"
            default:
                return "house"
        }
    }
}
