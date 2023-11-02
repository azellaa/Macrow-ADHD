//
//  SplashScreen.swift
//  MacroADHD-simulator
//
//  Created by Azella Mutyara on 30/10/23.
//
import SwiftUI

struct SplashScreen: View {
    @AppStorage("firstLaunch") var firstLaunch: Bool = true
    @GestureState private var isButtonPressed = false
    @State var isSplashScreenShown = false
    
    var body: some View {
        if isSplashScreenShown {
            if firstLaunch {
                DeviceTutorial()
            } else {
                HomeView()
            }
        } else {
            ZStack {
                Image("SplashScreenBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                
                VStack {
                    Text("Will &")
                        .font(.custom("Jua-Regular", size: 125))
                        .foregroundColor(Color.brownColor)
                        .multilineTextAlignment(.center)
                    
                    Text("The Cat")
                        .font(.custom("Jua-Regular", size: 100))
                        .foregroundColor(Color.brownColor)
                        .multilineTextAlignment(.center)
                    
                    Spacer().frame(height: 275)
                    
                    
                    TouchButton(padding: .constant(0), normalImageName: "PlayButtonNotPressed", pressedImageName: "PlayButtonPressed") {
                        isSplashScreenShown = true
                    }
                }
            }
        }
        
    }
}


#Preview {
    SplashScreen()
}
