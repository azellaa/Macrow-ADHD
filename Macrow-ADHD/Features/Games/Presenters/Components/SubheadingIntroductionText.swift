//
//  BubbleText.swift
//  MacroADHD-simulator
//
//  Created by Azella Mutyara on 30/10/23.
//

import SwiftUI

struct SubheadingIntroductionText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.body1)
            .foregroundColor(.brown1)
            .padding(.horizontal, UIScreen.main.bounds.width * (20 / UIScreen.main.bounds.width))
            .padding(.vertical, UIScreen.main.bounds.height * (5 / UIScreen.main.bounds.height))
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(.cream1)
                    .opacity(0.75)
            )
    }
}

#Preview {
    SubheadingIntroductionText(text: "Patience")
}
