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
                    DeviceTutorial(opacity: 0)
                } else {
//                    HomeView()
                //MARK: for exhibition, the device tutorial will always showed
                    DeviceTutorial(opacity: 0)
                }
            } else {
                ZStack {
                    Image(ResourcePath.mainBackground)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    
                    VStack {
                        Text(AppLabel.appNameLine1)
                            .font(.custom(AppFont.juaRegular, size: 125))
                            .foregroundColor(Color.brown1)
                            .multilineTextAlignment(.center)
                            .padding(.top, UIScreen.main.bounds.height * 0.07)
                        
                        Text(AppLabel.appNameLine2)
                            .font(.custom(AppFont.juaRegular, size: 100))
                            .foregroundColor(Color.brown1)
                            .multilineTextAlignment(.center)
                        
                        TextButton(contentType: .play, buttonStyle: .brown, buttonSize: .big) {
                            isSplashScreenShown = true
                        }
                        .padding(.top, UIScreen.main.bounds.height * 0.2)
                        
                    }
                    
                }
                .onAppear(perform: {
                    AudioManager.shared.playBackgroundMusic(fileName: ResourcePath.Sound.BackgroundMusic.homeMusic)
                })
                
            }
        }
    }
}


#Preview {
    SplashScreen()
}
