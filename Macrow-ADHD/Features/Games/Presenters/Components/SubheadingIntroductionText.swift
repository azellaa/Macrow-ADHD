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
            .font(.custom("Jua-Regular", size: 24))
            .foregroundColor(.brown1)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 37)
                    .fill(.cream1)
                    .opacity(0.75)
                    .frame(height: 38)
            )
    }
}

#Preview {
    SubheadingIntroductionText(text: "Patience")
}
