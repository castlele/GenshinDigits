//
//  SelectableByHover.swift
//  GenshinDigits (iOS)
//
//  Created by Nikita Semenov on 03.02.2022.
//

import SwiftUI

extension View {
    func selectableAsRectangle(_ isSelected: Bool, selection: [Color],
                               deselection: [Color] = [.clear],
                               start: UnitPoint = .bottom, end: UnitPoint = .center) -> some View {
        return self
            .overlay(
                Rectangle()
                    .selectableByHover(isSelected, selection: selection,
                                       deselection: deselection, start: start, end: end)
            )
    }
    
    func selectableAsCircle(_ isSelected: Bool, selection: [Color],
                            deselection: [Color] = [.clear],
                            start: CGFloat = 0, end: CGFloat = 0) -> some View {
        return self
            .overlay(
                Circle()
                    .selectableByHover(isSelected, selection: selection,
                                       deselection: deselection, start: start, end: end)
            )
    }
}

extension RoundedRectangle {
    func selectableByHover(_ isSelected: Bool, selection: [Color],
                           deselection: [Color] = [.clear],
                           start: UnitPoint = .bottom, end: UnitPoint = .center) -> some View {
        return self
            .selectableByHoverWithLinearGradient(isSelected, selection: selection,
                                                 deselection: deselection, start: start, end: end)
    }
}

extension Rectangle {
    func selectableByHover(_ isSelected: Bool, selection: [Color],
                           deselection: [Color] = [.clear],
                           start: UnitPoint = .bottom, end: UnitPoint = .center) -> some View {
        return self
            .selectableByHoverWithLinearGradient(isSelected, selection: selection,
                                                 deselection: deselection, start: start, end: end)
    }
}

extension Circle {
    func selectableByHover(_ isSelected: Bool, selection: [Color],
                           deselection: [Color] = [.clear],
                           start: CGFloat = 0, end: CGFloat = 0) -> some View {
        return self
            .selectableByHoverWithRaialGradient(isSelected, selection: selection,
                                                deselection: deselection, start: start, end: end)
    }
}

extension Shape {
    func selectableByHoverWithLinearGradient(_ isSelected: Bool,
                                             selection: [Color],
                                             deselection: [Color] = [.clear],
                                             start: UnitPoint,
                                             end: UnitPoint) -> some View {
        return self
            .fill(
                LinearGradient(colors: isSelected ? selection : deselection,
                               startPoint: start, endPoint: end)
            )
    }
    
    
    func selectableByHoverWithRaialGradient(_ isSelected: Bool,
                                            selection: [Color],
                                            deselection: [Color] = [.clear],
                                            start: CGFloat,
                                            end: CGFloat) -> some View {
        return self
            .fill(
                RadialGradient(colors: isSelected ? selection : deselection, center: .center,
                               startRadius: start, endRadius: end)
            )
    }
}
