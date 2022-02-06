//
//  SidebarButton.swift
//  GenshinDigits (macOS)
//
//  Created by Nikita Semenov on 29.01.2022.
//

import SwiftUI

struct SidebarButton: View {
    private let select: (() -> Void)?
    private let imageName: String
    private let width: CGFloat
    private let height: CGFloat
   
    var body: some View {
        Button {
            select?()
        } label: {
            Image(imageName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: width, height: height)
                .padding()
                .background(
                    Circle()
                        .fill(Color("sidebar-button-bg"))
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    init(_ imageName: String, width: CGFloat,
         height: CGFloat, select: (() -> Void)? = nil) {
        self.imageName = imageName
        self.width = width
        self.height = height
        self.select = select
    }
    
    init(_ imageName: String, diameter: CGFloat, select: (() -> Void)? = nil) {
        self.imageName = imageName
        self.width = diameter
        self.height = diameter
        self.select = select
    }
}

#if DEBUG
struct SidebarButton_Previews: PreviewProvider {
    static var previews: some View {
        SidebarButton("house", width: 50.0, height: 50.0) { print("Hello") }
    }
}
#endif
