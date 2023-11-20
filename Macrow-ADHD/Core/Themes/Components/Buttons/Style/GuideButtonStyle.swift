//
//  GuideButtonStyle.swift
//  Macrow-ADHD
//
//  Created by Jessica Rachel on 08/11/23.

import Foundation
import SwiftUI

struct GuideButtonStyle: ButtonStyle {
    
    var style: GuideButtonStyleEnum = .brown
    private var upperColor: Color = .brownGuide
    private var belowColor: Color = .darkBrown
    private var foregroundColor: Color = .white
    init(style: GuideButtonStyleEnum) {
        self.style = style
        switch style {
        case .brown:
            self.upperColor = .brownGuide
            self.belowColor = .darkBrown
            self.foregroundColor = .white
        case .lightBrown:
            self.upperColor = .lightBrown
            self.belowColor = .brownColor
            self.foregroundColor = .darkBrown
        case .white:
            self.upperColor = .white
            self.belowColor = .brownColor
            self.foregroundColor = .darkBrown
        case .nonInteractable:
            self.upperColor = .brownGuide
            self.belowColor = .brownColor
            self.foregroundColor = .white
        case .darkBrown:
            self.upperColor = .brown4
            self.belowColor = .brown5
            self.foregroundColor = .white
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
                    AudioManager.shared.playSoundEffect(fileName: ResourcePath.SoundEffect.buttonSound)
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
