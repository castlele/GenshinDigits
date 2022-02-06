//
//  SidebarView.swift
//  GenshinDigits
//
//  Created by Nikita Semenov on 29.01.2022.
//

import SwiftUI

struct SidebarView: View {
    private let buttonDiameter: CGFloat = 40
    private let sidebarWidth: CGFloat = 80
    private let sidebarButtonsSpacing: CGFloat = 50
    private let sidebarButtonsAmount = 0..<4
    
    @StateObject var sidebarViewModel = SidebarViewModel()
    
    private var title: some View {
        Group {
            switch sidebarViewModel.currentTab {
                case 0:
                    TitleText("News")
                case 1:
                    TitleText("Characters")
                default:
                    TitleText("News")
            }
        }
    }
    
    private var page: some View {
        Group {
            switch sidebarViewModel.currentTab {
                case 0:
                    HomeTab()
                case 1:
                    CharactersTab()
                default:
                    HomeTab()
            }
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: sidebarButtonsSpacing) {
                Spacer()
                
                ForEach(sidebarButtonsAmount) { tab in
                    SidebarButton(sidebarViewModel.getImageForButton(tab), diameter: buttonDiameter)
                        .selectableAsCircle(sidebarViewModel.hoveredTab == tab,
                                            selection: [.clear, .accentColor.opacity(0.3)],
                                            end: buttonDiameter)
                        .overlay(
                            Circle()
                                .stroke(
                                    sidebarViewModel.sidebarButtonStroke(tab: tab)
                                    , lineWidth: 2.5
                                )
                        )
                        .onHover { isHover in
                            sidebarViewModel.isHovering(isHover, currentTab: tab)
                        }
                        .onTapGesture {
                            sidebarViewModel.selectTab(tab)
                        }
                        .padding(.horizontal)
                }
                Spacer()
            }
            .frame(maxWidth: sidebarWidth)
            .background(
                LinearGradient(colors: [Color("sidebar-bg").opacity(0.75), Color("sidebar-bg").opacity(0.75), .clear], startPoint: .top, endPoint: .bottom	)
            )
            .overlay(Rectangle().stroke(Color("sidebar-accent"), lineWidth: 2.5))
            .padding(.horizontal)
            
            VStack {
                HStack(alignment: .firstTextBaseline) {
                    title
                        .padding(.leading)
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .padding()
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .frame(alignment: .topLeading)
                
                Divider()
                
                page
                    .frame(maxHeight: .infinity, alignment: .top)
            }
        }
    }
}

#if DEBUG
struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
#endif
