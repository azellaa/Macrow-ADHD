//
//  GuideButtonStyle.swift
//  Macrow-ADHD
//
//  Created by Jessica Rachel on 08/11/23.

import Foundation
import SwiftUI

struct GuideButtonStyle: ButtonStyle {
    
    var style: GuideButtonStyleEnum = .brown
    private var upperColor: Color = .brown1
    private var belowColor: Color = .brown2
    private var foregroundColor: Color = .white
    init(style: GuideButtonStyleEnum) {
        self.style = style
        switch style {
        case .brown:
            self.upperColor = .brown1
            self.belowColor = .brown2
            self.foregroundColor = .white1
        case .lightBrown:
            self.upperColor = .cream1
            self.belowColor = .cream2
            self.foregroundColor = .brown1
        case .white:
            self.upperColor = .white1
            self.belowColor = .cream1
            self.foregroundColor = .brown1
        case .nonInteractable:
            self.upperColor = .brown2
            self.belowColor = .brown1
            self.foregroundColor = .white1
        case .darkBrown:
            self.upperColor = .brown4
            self.belowColor = .brown5
            self.foregroundColor = .white1
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 150, height: 100)
            .background(self.upperColor)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .mask {
                RoundedRectangle(cornerRadius: 20)
                    .offset(y: configuration.isPressed ? 0 : -4)
            }
            .offset(y: configuration.isPressed ? 0 : -6)
            .background {
                RoundedRectangle(cornerRadius: 30)
                    .fill(self.belowColor)
            }
            .foregroundStyle(self.foregroundColor)
            .onChange(of: configuration.isPressed) { newValue in
                if newValue {
                    AudioManager.shared.playSoundEffect(fileName: ResourcePath.Sound.SoundEffect.buttonSound)
                }
            }
    }
    
    
}

extension GuideButtonStyle {
    enum GuideButtonStyleEnum {
        case brown
        case lightBrown
        case white
        case nonInteractable
        case darkBrown
    }
}

#Preview {
    Button {
        
    } label: {
        Text("Play")
    }
    .buttonStyle(GuideButtonStyle(style: .darkBrown))
    
}
