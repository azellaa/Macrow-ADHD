//
//  CustomTextButtonStyle.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/6/23.
//

import Foundation
import SwiftUI

struct TextButtonStyle: ButtonStyle {
    
    var style: TextButtonStyleEnum = .brown
    var size: TextButtonSizeEnum = .big
    private var upperColor: Color {
        switch style {
        case .brown:
            return .brown1
        case .lightBrown:
            return .cream1
        case .white:
            return .white1
        }
    }
    private var belowColor: Color {
        switch style {
        case .brown:
            return .brown2
        case .lightBrown:
            return .cream2
        case .white:
            return .cream1
        }
    }
    private var foregroundColor: Color {
        switch style {
        case .brown:
            return .white1
        case .lightBrown:
            return .brown1
        case .white:
            return .brown1
        }
    }
    init(style: TextButtonStyleEnum, size: TextButtonSizeEnum = .big) {
        self.style = style
        self.size = size
        
    }
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .frame(width: self.size == .big ? 445 : 230, height: self.size == .big ? 130 : 72)
            .background(
                self.upperColor
            )
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .mask {
                RoundedRectangle(cornerRadius: 20)
            }
            .offset(y: configuration.isPressed ? 0 : -14)
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

extension TextButtonStyle {
    enum TextButtonStyleEnum {
        case brown
        case lightBrown
        case white
    }
    enum TextButtonSizeEnum {
        case big
        case small
    }
}

#Preview {
    Button {
        
    } label: {
        Text("Play")
    }
    .buttonStyle(TextButtonStyle(style: .lightBrown))
    
}
