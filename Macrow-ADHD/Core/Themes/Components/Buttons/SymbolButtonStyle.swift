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
    private var upperColor: Color = .brownGuide
    private var belowColor: Color = .darkBrown
    private var foregroundColor: Color = .white
    init(style: SymbolButtonStyleEnum) {
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
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        
        if self.style == .nonInteractable {
            configuration.label
                .frame(width: 72, height: 72)
                .background(self.upperColor)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .overlay {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.shadow(.inner(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)))
                        .frame(width: 61, height: 61)
                        .foregroundStyle(.brownGuide)
//                    configuration.label
                }
                .disabled(true)
                .foregroundStyle(self.foregroundColor)
        } else {
            configuration.label
                .frame(width: 72, height: 72)
                .background(self.upperColor)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .mask {
                    RoundedRectangle(cornerRadius: 20)
//                        .offset(y: configuration.isPressed ? 0 : -4)
                }
                .offset(y: configuration.isPressed ? 0 : -8)
                .background {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(self.belowColor)
                }
                .foregroundStyle(self.foregroundColor)
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
    .buttonStyle(SymbolButtonStyle(style: .nonInteractable))

}
