//
//  Hide&SeekIntroduction.swift
//  MacroADHD-simulator
//
//  Created by Azella Mutyara on 30/10/23.
//

import SwiftUI

struct Hide_SeekIntroduction: View {
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
                            //action
                        })
                        
                        Spacer().frame(width: 450)
                        
                        TouchButton(normalImageName: "GuideButtonNotPressed",
                                    pressedImageName: "GuideButtonNotPressed",
                                    action: {
                            //action
                        })
                        
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
                    
                    VStack{
                        Text("Choose Level")
                            .font(.custom("Jua-Regular", size: 45))
                            .foregroundColor(Color.brownColor)
                            .position(x:230, y: 80)
                        
                        
                        
                        Rectangle()
                            .frame(width: 9
                                   , height: 195)
                            .position(x: 170)
                        
                        TouchButton(normalImageName: "PlayButtonNotPressed2",
                                    pressedImageName: "PlayButtonPressed2",
                                    action: {
                            //Action
                        })
                        .position(x: 300, y: 160)
                        
                    }
                }
            }
        }
    }
}


#Preview {
    Hide_SeekIntroduction()
}
