
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
    
    @Environment(\.presentationMode) var presentationMode
    
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
    @State private var headpieceIndicator = ResourcePath.headpieceDisconnected
    
    @State private var levels: [Level] = [
        Level(number: 1, isCompleted: true, text: AppLabel.IntroductionView.HideAndSeek.level1),
        Level(number: 2, isCompleted: false, text:  AppLabel.IntroductionView.HideAndSeek.level2),
        Level(number: 3, isCompleted: false, text:  AppLabel.IntroductionView.HideAndSeek.level3)
        // Add more levels as needed
    ]
    
    var body: some View {
        ZStack{
            Image(ResourcePath.IntroductionView.HideAndSeek.background)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            HStack{
                VStack{
                    HStack{
                        Spacer().frame(width: 15)
                        
                        SymbolButton(type: .back, buttonStyle: .brown, action: {presentationMode.wrappedValue.dismiss()})
                        
                        Spacer().frame(width: 500)
                        
                        NavigationLink {
                            GuideView()
                        } label: {
                            Image(headpieceIndicator)
                        }
                        .buttonStyle(SymbolButtonStyle(style: .brown))

                    }
                    .padding(.top, 25)
                    
                    Spacer().frame(height: 450)
                    
                    VStack {
                        Text(AppLabel.IntroductionView.HideAndSeek.name)
                            .font(.custom(AppFont.juaRegular, size: 64))
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        HStack {
                            ForEach(AppLabel.IntroductionView.HideAndSeek.subheading, id: \.self) { subheading in
                                SubheadingIntroductionText(text: subheading)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, -20)
                        
                        Text(AppLabel.IntroductionView.HideAndSeek.description)
                            .font(.custom(AppFont.juaRegular, size: 24))
                            .kerning(3)
                            .lineSpacing(5)
                            .foregroundColor(Color.white)
                            .frame(width: 588, height: 150, alignment: .leading)
                            .multilineTextAlignment(.leading)
                    }
//                    .padding(.bottom, height * 0.3)
                    
                }
                .frame(width: 600)
                .padding(.leading, 45)
                
                ZStack {
                    Image("LevelingBackground")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    //                    Rectangle()
                    //                        .frame(width: 487, height: 835)
                    //                        .cornerRadius(50)
                    //                        .offset(y: -2)
                    //
                    //                    Rectangle()
                    //                        .frame(width: 487, height: 835)
                    //                        .offset(x: 487 / 2, y: -2)
                    
                    
                    VStack {
                        Text("Level")
                            .font(.custom(AppFont.juaRegular, size: 45))
                            .foregroundColor(Color.brownColor)
                            .position(x: 190, y: 70)
                        
                        
                        VStack {
                            ForEach(levels.indices, id: \.self) { index in
                                HStack {
                                    ZStack {
                                        Image(levels[index].isCompleted ? "levelPresent" : "levelUndone")
                                            .resizable()
                                            .frame(width: 50, height: 55)
                                        
                                        Text("\(levels[index].number)")
                                            .foregroundColor(levels[index].isCompleted ? Color.white : Color("grey2Color"))
                                            .font(.custom(AppFont.juaRegular, size: 28))
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
                                    .font(.custom(AppFont.juaRegular, size: 36))
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
                        
                        TextButton(contentType: .play, buttonStyle: .brown, buttonSize: .small) {
                            showGameView = true
                        }
                        .padding(.leading, 65)
                        .padding(.bottom, 50)
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
                self.headpieceIndicator = ResourcePath.headpiece1Bar
                isDisconnected = false
            case 2:
                self.headpieceIndicator = ResourcePath.headpiece2Bar
                isDisconnected = false
            case 3:
                self.headpieceIndicator = ResourcePath.headpiece3Bar
                isDisconnected = false
            case 4:
                self.headpieceIndicator = ResourcePath.headpieceConnected
                isDisconnected = false
            default:
                self.headpieceIndicator = ResourcePath.headpieceDisconnected
                isDisconnected = true
                break
            }
        })
        .overlay(
            Group {
                if isDisconnected{
                    DisconnectedOverlay()
                }
            }
        )
    }
}



#Preview {
    Hide_SeekIntroduction(currentGame: GameInfo(name: AppLabel.HomeView.game1Name, description: AppLabel.HomeView.game1Description, imageName: ResourcePath.HomeView.homeHideAndSeek, destination: HideAndSeekWithHeadpiece(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)), mainFocus: AppLabel.HomeView.game1MainFocus), width: 100, height: 100)
}


