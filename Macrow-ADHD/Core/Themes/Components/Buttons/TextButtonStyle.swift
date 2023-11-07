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
    private var upperColor: Color = .brownGuide
    private var belowColor: Color = .darkBrown
    private var foregroundColor: Color = .white
    init(style: TextButtonStyleEnum, size: TextButtonSizeEnum = .big) {
        self.style = style
        self.size = size
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
            .frame(width: self.size == .big ? 445 : 230, height: self.size == .big ? 130 : 72)
            .background(
                self.upperColor
            )
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .mask {
                RoundedRectangle(cornerRadius: 20)
//                    .offset(y: configuration.isPressed ? 0 : -4)
            }
            .offset(y: configuration.isPressed ? 0 : -14)
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
    .buttonStyle(TextButtonStyle(style: .brown))
    
}
