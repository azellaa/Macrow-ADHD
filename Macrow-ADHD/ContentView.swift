//
//  ContentView.swift
//  Macrow-ADHD
//
//  Created by Azella Mutyara on 28/09/23.
//

import SwiftUI
import _SpriteKit_SwiftUI

struct ContentView: View {
    var body: some View {
        SpriteView(scene: HideAndSeekScene())
            .ignoresSafeArea()
            .navigationBarBackButtonHidden()
    }
}

#Preview {
    ContentView()
}
