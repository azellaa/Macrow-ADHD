//
//  SymbolButton.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/7/23.
//

import SwiftUI

struct GuideButton: View {
    let action: () -> Void
    let type: GuideContentEnum
    var buttonStyle: GuideButtonStyle.GuideButtonStyleEnum = .brown
    init(action: @escaping () -> Void, type: GuideContentEnum, buttonStyle: GuideButtonStyle.GuideButtonStyleEnum = .brown) {
        self.action = action
        self.type = type
        self.buttonStyle = buttonStyle
    }
    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            switch self.type {
            case .notConnected:
                Image(ResourcePath.notConnected)
                    .resizable()
                    .frame(width: 53, height: 42)
                    .padding(.trailing)
            case .connected:
                Image(ResourcePath.connected)
                    .resizable()
                    .frame(width: 53, height: 42)
                    .padding(.trailing)
            case .connecting1:
                Image(ResourcePath.connecting1)
                    .resizable()
                    .frame(width: 53, height: 42)
                    .padding(.trailing)
            case .connecting2:
                Image(ResourcePath.connecting2)
                    .resizable()
                    .frame(width: 53, height: 42)
                    .padding(.trailing)
            case .connecting3:
                Image(ResourcePath.connecting3)
                    .resizable()
                    .frame(width: 53, height: 42)
                    .padding(.trailing)
            }
        })
        .buttonStyle(GuideButtonStyle(style: self.buttonStyle))
    }
}

extension GuideButton {
    enum GuideContentEnum {
        case notConnected
        case connected
        case connecting1
        case connecting2
        case connecting3
    }
}

#Preview {
    GuideButton(action: {}, type: .notConnected, buttonStyle: .darkBrown)
}
