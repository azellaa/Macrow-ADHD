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
        ZStack {
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
                        Text("Will's")
                            .font(.custom("Jua-Regular", size: 125))
                            .foregroundColor(Color.brownColor)
                            .multilineTextAlignment(.center)
                            .padding(.top, UIScreen.main.bounds.height * 0.07)
                        
                        Text("Storyland")
                            .font(.custom("Jua-Regular", size: 100))
                            .foregroundColor(Color.brownColor)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        ButtonText(imageName: "IconPlay", text: "Play", textSize: 55, textColor: .white, normalImageName: "brownSplashNotPressed", pressedImageName: "brownSplashPressed") {
                            isSplashScreenShown = true
                        }
                        .padding(.bottom, UIScreen.main.bounds.height * 0.01)
                    }
                }
            }
        }
        
        
    }
}


#Preview {
    SplashScreen()
}
