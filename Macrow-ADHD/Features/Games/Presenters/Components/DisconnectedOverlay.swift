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
                .zIndex(0)
            
            Image(ResourcePath.disconnectedPopUp)
                .zIndex(1)
        }
    }
}

#Preview {
    DisconnectedOverlay()
}
