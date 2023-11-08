
//
//  Hide&SeekIntroduction.swift
//  MacroADHD-simulator
//
//  Created by Azella Mutyara on 30/10/23.
//

import SwiftUI
import SpriteKit

struct Hide_SeekIntroduction: View {
    var currentGame: GameInfo
    var width: CGFloat
    var height: CGFloat
    
    init(currentGame: GameInfo, width: CGFloat, height: CGFloat) {
        self.currentGame = currentGame
        self.width = width
        self.height = height
    }
    
    struct Level {
        var number: Int
        var isCompleted: Bool
        var text: String
    }
    @State private var showGameView = false
    @State private var showGuideView = false
    @State private var showHomeView = false
    @ObservedObject var mwmObject: MWMInstance = MWMInstance.shared
    @State private var mwmData: MWMData?
#if targetEnvironment(simulator)
    @State private var isDisconnected = false
    
#else
    @State private var isDisconnected = true
#endif
    @State private var imageName = ResourcePath.notConnected
    
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
                        
                        ButtonBack()
                            .frame(width: 100, height: 100)
                        
                        Spacer().frame(width: 450)
                        
                        ButtonSymbol(dest: $showGuideView, imageName: imageName)
                            .navigationDestination(isPresented: $showGuideView, destination: {
                                GuideView()
                            })
                            .padding(.trailing, width * 0.03)
                        
                        
                        
                    }
                    .padding(.top, height * 0.03)
                    
                    Spacer()
                    
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
                        
                        Text("On his way in the forest, Will finds a rabbit that needs to hide from the fox. To safe the rabbit, you need to keep the rabbit hidden from the sly fox.")
                            .font(.custom("Jua-Regular", size: 24))
                            .kerning(3)
                            .lineSpacing(5)
                            .foregroundColor(Color.white)
                            .frame(width: 588, height: 150, alignment: .leading)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.bottom, height * 0.08)
                    
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
                                    .padding(.top, 120)
                                    .padding(.trailing, 200)
                                    .onTapGesture {
                                        if levels[index].number == 1 {
                                            // Set the isCompleted property to true for the number 1 level
                                            //                                            levels[index].isCompleted
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
                            .frame(width: 9, height: 190)
                            .position(x: 170)
                            .padding(.top, -174)
                            .foregroundColor(Color("greyColor"))
                            .zIndex(0)
                        
                        Rectangle()
                            .frame(width: 9, height: 190)
                            .position(x: 170)
                            .padding(.top, -414)
                            .foregroundColor(Color("greyColor"))
                            .zIndex(0)
                        
                        ButtonText(imageName: "IconPlay", text: "Play", textSize: 32, textColor: .white, normalImageName: "brownTextButtonNotPressed", pressedImageName: "brownTextButtonPressed") {
                            showGameView = true
                        }
                        .frame(height: height * 0.1)
                        .padding(.bottom, height * 0.08)
                        .navigationDestination(isPresented: $showGameView, destination: {
                            GameElementTutorialView(currentGame: currentGame, width: width, height: height)
                        })
                        
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onReceive(mwmObject.signalStatusPublisher, perform: { signalStatus in
            switch signalStatus {
            case 1:
                self.imageName = ResourcePath.connecting1
                isDisconnected = false
            case 2:
                self.imageName = ResourcePath.connecting2
                isDisconnected = false
            case 3:
                self.imageName = ResourcePath.connecting3
                isDisconnected = false
            case 4:
                self.imageName = ResourcePath.connected
                isDisconnected = false
            default:
                self.imageName = ResourcePath.notConnected
                isDisconnected = true
                break
            }
        })
        .overlay(
            Group {
                if isDisconnected{
                    
                    Image("disconnectedPopUp")
                }
            }
        )
    }
}



//#Preview {
//    Hide_SeekIntroduction()
//}


