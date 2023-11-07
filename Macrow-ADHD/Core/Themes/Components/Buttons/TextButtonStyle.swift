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
    private var upperColor: Color = .brownGuide
    private var belowColor: Color = .darkBrown
    private var foregroundColor: Color = .white
    init(style: TextButtonStyleEnum) {
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
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .frame(width: 393, height: 80)
            .background(
                self.upperColor
            )
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .mask {
                RoundedRectangle(cornerRadius: 20)
                    .offset(y: configuration.isPressed ? 0 : -4)
            }
            .offset(y: configuration.isPressed ? 0 : -12)
            .background {
                RoundedRectangle(cornerRadius: 30)
                    .fill(self.belowColor)
            }
            .foregroundStyle(self.foregroundColor)
        
    }
}

extension TextButtonStyle {
    enum TextButtonStyleEnum {
        case brown
        case lightBrown
        case white
    }
}

#Preview {
    Button {
        
    } label: {
        Text("Play")
    }
    .buttonStyle(TextButtonStyle(style: .brown))
    
}
