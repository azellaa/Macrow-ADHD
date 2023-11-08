//
//  DisconnectedOverlay.swift
//  Macrow-ADHD
//
//  Created by Azella Mutyara on 07/11/23.
//

import SwiftUI

struct DisconnectedOverlay: View {
    var body: some View {
        
        Image(ResourcePath.disconnectedPopUp)
            .background{
                Color.black
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.5)
        }
    }
}

#Preview {
    DisconnectedOverlay()
}
