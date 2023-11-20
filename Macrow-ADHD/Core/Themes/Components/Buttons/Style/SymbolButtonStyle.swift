//
//  SymbolButtonStyle.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/7/23.
//

import Foundation
import SwiftUI

struct SymbolButtonStyle: ButtonStyle {
    
    var style: SymbolButtonStyleEnum = .brown
    private var upperColor: Color {
        switch style {
        case .brown:
            return .brown1
        case .lightBrown:
            return .cream1
        case .white:
            return .white1
        case .nonInteractable:
            return .brown2
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
        case .nonInteractable:
            return .brown1
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
        case .nonInteractable:
            return .white1
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        
        if self.style == .nonInteractable {
            configuration.label
                .frame(width: 72, height: 72)
                .background(self.belowColor)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .overlay {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.shadow(.inner(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)))
                        .frame(width: 61, height: 61)
                        .foregroundStyle(self.upperColor)
                    configuration.label
                }
                .disabled(true)
                .foregroundStyle(self.foregroundColor)
        } else {
            configuration.label
                .frame(width: 72, height: 72)
                .background(self.upperColor)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .mask {
                    RoundedRectangle(cornerRadius: 30)
                }
                .offset(y: configuration.isPressed ? 0 : -8)
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
}
extension SymbolButtonStyle {
    enum SymbolButtonStyleEnum {
        case brown
        case lightBrown
        case white
        case nonInteractable
    }
}

#Preview {
    Button {
        
    } label: {
        Text("Play")
    }
    .buttonStyle(SymbolButtonStyle(style: .brown))

}
