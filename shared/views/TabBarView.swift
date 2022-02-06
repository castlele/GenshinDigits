//
//  TabBarView.swift
//  GenshinDigits
//
//  Created by Nikita Semenov on 29.01.2022.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        #if os(macOS)
        SidebarView()
        #else
        Text("IOS")
        #endif
    }
}

#if DEBUG
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
#endif
