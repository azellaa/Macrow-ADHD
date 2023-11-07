//
//  SymbolButton.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/7/23.
//

import SwiftUI

struct SymbolButton: View {
    let action: () -> Void
    let type: SymbolContentEnum
    var buttonStyle: SymbolButtonStyle.SymbolButtonStyleEnum = .brown
    init(action: @escaping () -> Void, type: SymbolContentEnum, buttonStyle: SymbolButtonStyle.SymbolButtonStyleEnum = .brown) {
        self.action = action
        self.type = type
        self.buttonStyle = buttonStyle
    }
    var body: some View {
        Button(action: self.action, label: {
            switch self.type {
            case .back:
                Image(ResourcePath.backWhite)
            case .share:
                Image(ResourcePath.shareWhite)
            case .statistic:
                Image(ResourcePath.statisticWhite)
            case .guide:
                Image(ResourcePath.guideWhite)
            case .close:
                Image(ResourcePath.closeWhite)
            }
        })
        .buttonStyle(SymbolButtonStyle(style: self.buttonStyle))
    }
}

extension SymbolButton {
    enum SymbolContentEnum {
        case back
        case share
        case statistic
        case guide
        case close
    }
}

#Preview {
    SymbolButton(action: {}, type: .guide, buttonStyle: .nonInteractable)
}
