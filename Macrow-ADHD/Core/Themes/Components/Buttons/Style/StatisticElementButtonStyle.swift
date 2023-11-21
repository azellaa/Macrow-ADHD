//
//  StatisticElementButtonStyle.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/7/23.
//

import Foundation
import SwiftUI
struct StatisticElementButtonStyle: ButtonStyle {
    
    var isActive: Bool = false
    var belowColor: Color {
        if !isActive {
            return .brown2
        } else {
            return .cream1
        }
    }
    var foregroundColor: Color {
        if !isActive {
            return .white1
        } else {
            return .brown1
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        
        if isActive {
            configuration.label
                .frame(width: 309, height: 62)
                .background(self.belowColor)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .offset(y: configuration.isPressed ? 0 : -8)
                .foregroundStyle(self.foregroundColor)
                .onChange(of: configuration.isPressed) { newValue in
                    if newValue {
                        AudioManager.shared.playSoundEffect(fileName: ResourcePath.Sound.SoundEffect.buttonSound)
                    }
                }
        } else {
            configuration.label
                .frame(width: 309, height: 62)
                .background(.brown1)
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
        }
    }
}

#Preview {
    Button {
        
    } label: {
        Text("Play")
    }
    .buttonStyle(StatisticElementButtonStyle(isActive: true))

}
