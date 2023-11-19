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
    init(type: SymbolContentEnum, buttonStyle: SymbolButtonStyle.SymbolButtonStyleEnum = .brown, action: @escaping () -> Void) {
        self.action = action
        self.type = type
        self.buttonStyle = buttonStyle
    }
    var body: some View {
        Button(action: {
            self.action()
            AudioManager.shared.playSoundEffect(fileName: ResourcePath.SoundEffect.buttonSound)
        }, label: {
            switch self.type {
            case .back:
                Image(ResourcePath.backWhite)
                    .resizable()
                    .frame(width: Decimal.double40, height: Decimal.double40)
            case .share:
                Image(ResourcePath.shareWhite)
                    .resizable()
                    .frame(width: Decimal.double40, height: Decimal.double40)
            case .statistic:
                Image(ResourcePath.statisticWhite)
                    .resizable()
                    .frame(width: Decimal.double40, height: Decimal.double40)
            case .guide:
                Image(ResourcePath.guideWhite)
                    .resizable()
                    .frame(width: Decimal.double40, height: Decimal.double40)
            case .close:
                Image(ResourcePath.closeWhite)
                    .resizable()
                    .frame(width: Decimal.double40, height: Decimal.double40)
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
    SymbolButton(type: .back, buttonStyle: .brown, action: {})
}
