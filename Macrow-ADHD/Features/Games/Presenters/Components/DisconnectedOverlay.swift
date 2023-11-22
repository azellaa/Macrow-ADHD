//
//  DisconnectedOverlay.swift
//  Macrow-ADHD
//
//  Created by Azella Mutyara on 07/11/23.
//

import SwiftUI

struct DisconnectedOverlay: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
                .opacity(0.5)
            
            Image(ResourcePath.disconnectedPopUp)
            
            SymbolButton(type: .back, buttonStyle: .brown, action: {
                presentationMode.wrappedValue.dismiss()
            })
            .position(x: UIScreen.main.bounds.width * 0.056, y: UIScreen.main.bounds.height * 0.077)
        }
    }
}

#Preview {
    DisconnectedOverlay()
}
