
//
//  Hide&SeekIntroduction.swift
//  MacroADHD-simulator
//
//  Created by Azella Mutyara on 30/10/23.
//

import SwiftUI
import SpriteKit

struct Hide_SeekIntroduction: View {
    struct Level {
        var number: Int
        var isCompleted: Bool
        var text: String
    }
    @State private var showGameView = false
    @State private var showGuideView = false
    @State private var showHomeView = false

    @State private var levels: [Level] = [
        Level(number: 1, isCompleted: true, text: "Beginner"),
        Level(number: 2, isCompleted: false, text: "Intermediate"),
        Level(number: 3, isCompleted: false, text: "Advanced")
        // Add more levels as needed
    ]
    
    var body: some View {
        ZStack{
            Image("HideNSeekIntroductionBackground") // Replace "yourImageName" with the actual name of your image asset
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            HStack{
                VStack{
                    HStack{
                        Spacer().frame(width: 15)
                        
                        TouchButton(normalImageName: "BackButtonNotPressed",
                                    pressedImageName: "BackButtonNotPressed",
                                    action: {
                            showHomeView = true
                        }) .background (NavigationLink("", destination:  HomeView(), isActive: $showHomeView))
                        
                        Spacer().frame(width: 450)
                        
                        TouchButton(normalImageName: "GuideButtonNotPressed",
                                    pressedImageName: "GuideButtonNotPressed",
                                    action: {
                            showGuideView = true
                        })  .background (NavigationLink("", destination:  GuideView(), isActive: $showGuideView))
                        
                        
                    }
                    .position(x: 300, y:70)
                    
                    
                    VStack {
                        Text("Hide & Seek")
                            .font(.custom("Jua-Regular", size: 64))
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        HStack{
                            BubbleText(text: "Patience")
                            BubbleText(text: "Selective Focus")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, -20)
                        .padding(.bottom, 15)
                        
                        Text("The purpose of this game is to tap the rabbits and ignore the fox. This game will teach child to be patient and learn to ignore distraction")
                            .font(.custom("Jua-Regular", size: 30))
                            .foregroundColor(Color.white)
                            .frame(width: 588, height: 120, alignment: .leading)
                            .multilineTextAlignment(.leading)
                    }
                    .position(x:300, y: 230)
                    
                }
                .frame(width: 600)
                .padding(.leading, 45)
                
                ZStack {
                    Image("LevelingBackground")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    VStack {
                        Text("Choose Level")
                            .font(.custom("Jua-Regular", size: 45))
                            .foregroundColor(Color.brownColor)
                            .position(x: 230, y: 80)
                        
            
                        VStack {
                            ForEach(levels.indices, id: \.self) { index in
                                HStack {
                                    ZStack {
                                        Image(levels[index].isCompleted ? "levelPresent" : "levelUndone")
                                            .resizable()
                                            .frame(width: 50, height: 55)
                                        
                                        Text("\(levels[index].number)")
                                            .foregroundColor(levels[index].isCompleted ? Color.white : Color("grey2Color"))
                                            .font(.custom("Jua-Regular", size: 28))
                                    }
                                    .padding(.top, 150)
                                    .padding(.trailing, 200)
                                    .onTapGesture {
                                        if levels[index].number == 1 {
                                            // Set the isCompleted property to true for the number 1 level
                                            levels[index].isCompleted
                                        }
                                    }
                                }
                                Text(levels[index].text)
                                    .font(.custom("Jua-Regular", size: 36))
                                    .foregroundColor(Color("darkBrown"))
                                    .padding(.top, -60)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 250)
                            }
                        }
                        .zIndex(1)
                        
                        Rectangle()
                            .frame(width: 9, height: 194)
                            .position(x: 170)
                            .padding(.top, -160)
                            .foregroundColor(Color("greyColor"))
                            .zIndex(0)
                        
                        Rectangle()
                            .frame(width: 9, height: 194)
                            .position(x: 170)
                            .padding(.top, -400)
                            .foregroundColor(Color("greyColor"))
                            .zIndex(0)
                        
                        TouchButton(normalImageName: "PlayButtonNotPressed2", pressedImageName: "PlayButtonPressed2", action: {
                            showGameView = true
                        })
                        .padding(.bottom, 20)
                    }
                }
            }
        } .background (NavigationLink("", destination:  GameView(scene: HideAndSeekScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))), isActive: $showGameView))
        .navigationBarBackButtonHidden(true)
        
    }
}



#Preview {
    Hide_SeekIntroduction()
}


