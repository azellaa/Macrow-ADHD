//
//  SplashScreen.swift
//  MacroADHD-simulator
//
//  Created by Azella Mutyara on 30/10/23.
//

import SwiftUI



struct SplashScreen: View {
    //    @State private var isButtonPressed = false
    @GestureState private var isButtonPressed = false
    @State private var buttonState = false
    @State private var shouldNavigate = false
    
    var body: some View {
        
        ZStack {
            Image("SplashScreenBackground") // Replace "yourImageName" with the actual name of your image asset
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
                
                TouchButton(normalImageName: "PlayButtonNotPressed",
                            pressedImageName: "PlayButtonPressed",
                            action: {
                    shouldNavigate = true
                })
            }
        }
        .background(
            NavigationLink("", destination: HomeView(), isActive: $shouldNavigate)
                .opacity(0)
        )
    }
}

#Preview {
    SplashScreen()
}
