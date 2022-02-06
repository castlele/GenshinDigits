//
//  TitleText.swift
//  GenshinDigits (macOS)
//
//  Created by Nikita Semenov on 30.01.2022.
//

import SwiftUI

struct TitleText: View {
    private let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 50, design: .default))
            .bold()
            .lineLimit(1)
            .truncationMode(.tail)
    }
    
    init(_ text: String) {
        self.text = text
    }
}

#if DEBUG
struct TitleText_Previews: PreviewProvider {
    static var previews: some View {
        TitleText("HOME")
    }
}
#endif
