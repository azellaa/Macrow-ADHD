//
//  AboutCard.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/7/23.
//

import SwiftUI

struct AboutCard: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 50)
            .fill(.white1)
            .frame(width: 1036, height: 160)
            .overlay {
                RoundedRectangle(cornerRadius: 50)
                    .stroke(.brown2, lineWidth: 4)
                    .frame(width: 1036, height: 160)
                Text(AppLabel.StatisticView.aboutText)
                    .font(.body2)
                    .foregroundStyle(.brown2)
                    .padding(.horizontal, 57)
                    .padding(.vertical, 30)
                    .lineSpacing(3)
            }
    }
}

#Preview {
    AboutCard()
}
