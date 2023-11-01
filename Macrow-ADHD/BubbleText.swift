//
//  BubbleText.swift
//  MacroADHD-simulator
//
//  Created by Azella Mutyara on 30/10/23.
//

import SwiftUI

struct BubbleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.custom("Jua-Regular", size: 24))
            .foregroundColor(Color.brownColor)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 37)
                    .fill(Color("bubbleColor"))
                    .opacity(0.75)
            )
    }
}

#Preview {
    BubbleText(text: "Patience")
}
