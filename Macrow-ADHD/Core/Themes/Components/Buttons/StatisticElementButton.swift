//
//  StatisticElementButton.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/7/23.
//

import SwiftUI

struct StatisticElementButton: View {
    var isActive: Bool = false
    let leftText: String
    let rightText: String
    let action: () -> Void
    var body: some View {
        Button(action: {
            self.action()
            AudioManager.shared.playSoundEffect(fileName: ResourcePath.SoundEffect.buttonSound)
        }, label: {
            HStack(content: {
                Text(leftText)
                Spacer()
                Text(rightText)
            })
            .font(.body1)
            .padding(.horizontal, 16)
        })
        .buttonStyle(StatisticElementButtonStyle(isActive: self.isActive))
    }
}

#Preview {
    StatisticElementButton(leftText: "Rabbit Count", rightText: "12", action: {})
}
