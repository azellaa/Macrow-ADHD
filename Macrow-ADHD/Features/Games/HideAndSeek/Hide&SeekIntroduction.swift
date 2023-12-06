
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
    @State var totalStarCount: Int = 0
    
    @Environment(\.presentationMode) var presentationMode
    
    init(currentGame: GameInfo) {
        self.currentGame = currentGame
        self.width = UIScreen.main.bounds.width
        self.height = UIScreen.main.bounds.height
    }
    
    struct Level {
        var number: Int
        var isCompleted: Bool
        var text: String
        var maxStar: Int
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
    @State private var headpieceIndicator = ResourcePath.notConnected
    
    @State private var levels: [Level] = [
        Level(number: 1, isCompleted: true, text: AppLabel.IntroductionView.level1, maxStar: AppLabel.IntroductionView.maxStarLevel1),
        Level(number: 2, isCompleted: false, text:  AppLabel.IntroductionView.level2, maxStar: AppLabel.IntroductionView.maxStarLevel2),
        Level(number: 3, isCompleted: false, text:  AppLabel.IntroductionView.level3, maxStar: AppLabel.IntroductionView.maxStarLevel3)
        // Add more levels as needed
    ]
    
    var body: some View {
        ZStack{
            Image(currentGame.gameIntroBg)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            
            HStack {
                VStack{
                    HStack{
                        
                        Spacer()
                        
                        NavigationLink {
                            GuideView()
                        } label: {
                            Image(headpieceIndicator)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        }
                        .buttonStyle(SymbolButtonStyle(style: .brown))

                    }
                    .padding(.top, height * (40 / height))
                    
                    Spacer()
                    
                    VStack (alignment: .leading, spacing: 0) {
                        Text(currentGame.name)
                            .font(.heading1)
                            .foregroundColor(Color.white1)
                            .frame(height: height * (78 / height))
                        
                        
                        HStack {
                            ForEach(currentGame.mainFocus, id: \.self) { subheading in
                                SubheadingIntroductionText(text: subheading)
                            }
                        }
                        .padding(.leading, width * (3 / width))
                        .padding(.bottom, height * (40 / height))
                        
                        Text(currentGame.description)
                            .font(.body1)
                            .lineSpacing(6)
                            .foregroundColor(Color.white1)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, width * (3 / width))
                    }
                    .padding(.leading, width * (20 / width))
                    .padding(.trailing, width * (32 / width))
                    .padding(.bottom, height * (135 / height))
                    
                }
                .padding(.horizontal, width * (32 / width))
                
                
                ZStack (alignment: .leading) {
                    Image("LevelingBackground")
                        .resizable()
                    
                    Rectangle()
                        .frame(width: width * (9 / width), height: height * (400 / height))
                        .foregroundColor(.cream2)
                        .padding(.leading, width * (70 / width))
                    
                    VStack (alignment: .leading) {
                        Text("Level")
                            .font(.heading2)
                            .foregroundColor(Color.brown1)
                        
                        VStack {
                            ForEach(levels.indices, id: \.self) { index in
                                ChoseLevelComponent(starCount: totalStarCount, isCompleted: levels[index].isCompleted, text: levels[index].text, maxStar: levels[index].maxStar)
                                    .padding(.bottom, height * (60 / height))
                            }
                        }
                        .padding(.top, height * (19 / height))
                        
                        HStack {
                            Spacer()
                            TextButton(contentType: .play, buttonStyle: .brown, buttonSize: .small) {
                                showGameView = true
                            }
                            Spacer()
                        }
                        .navigationDestination(isPresented: $showGameView, destination: {
                            GameElementTutorialView(currentGame: currentGame)
                        })
                        
                    }
                    .padding(.leading, width * (50 / width))
                }
                .frame(width: width * (487 / width))
            }
                HStack(alignment: .top, content: {
                    VStack(content: {
                        
                        SymbolButton(type: .back, buttonStyle: .brown, action: {presentationMode.wrappedValue.dismiss()})
                        Spacer()
                    })
                    Spacer()
                })
                .padding(.top, height * (40 / height))
                .padding(.horizontal, 32)
                .zIndex(1)
                .frame(height: UIScreen.main.bounds.height)
                
                Spacer()
            
            if isDisconnected{
                DisconnectedOverlay()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onReceive(mwmObject.signalStatusPublisher, perform: { signalStatus in
            switch signalStatus {
            case 1:
                self.headpieceIndicator = ResourcePath.connecting1
                isDisconnected = false
            case 2:
                self.headpieceIndicator = ResourcePath.connecting2
                isDisconnected = false
            case 3:
                self.headpieceIndicator = ResourcePath.connecting3
                isDisconnected = false
            case 4:
                self.headpieceIndicator = ResourcePath.connected
                isDisconnected = false
            default:
                self.headpieceIndicator = ResourcePath.notConnected
                isDisconnected = true
                break
            }
        })
        .onAppear {
            let reports = DataController.shared.fetchReports()
            var gameCount = 0
            for report in reports {
                if let animalsCount = report.reportToGame?.animals.count {
                    gameCount += animalsCount
                }
            }
            totalStarCount = gameCount
        }
    }
}



#Preview {
    Hide_SeekIntroduction(currentGame: GameInfo(currentGame: .hideAndSeek))
}


