//
//  ContentView.swift
//  Macrow-ADHD
//
//  Created by Azella Mutyara on 28/09/23.
//

import SwiftUI
import _SpriteKit_SwiftUI

struct ContentView: View {
//    @Environment (\.managedObjectContext) var managedObjContext
    var body: some View {
        NavigationStack {
//            SplashScreen()
            
            Hide_SeekIntroduction(currentGame: GameInfoLabel.games[0])
        }
    }
}

#Preview {
    ContentView()
}

