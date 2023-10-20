//
//  GameDescriptionView.swift
//  Macrow-ADHD
//
//  Created by Priskilla Adriani on 18/10/23.
//

import SwiftUI

struct GameDescriptionView: View {
    var currentGame: GameInfo
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    BackButton(width: width * 0.08, height: height * 0.1)
                        .padding(.leading)
                        .padding()
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text(currentGame.name)
                        .font(.custom("Jua-Regular", size: 72))
                        .foregroundColor(Color.brownColor)
                    Spacer()
                }
            }
            .padding(.bottom)
            Spacer()
            ZStack {
                Image("brownBox")
                VStack {
                    ZStack {
                        Image("whiteBox")
                            .resizable()
                            .frame(width: width * 0.85, height: height * 0.12)
                        Text(currentGame.mainFocus)
                            .font(.custom("Jua-Regular", size: 36))
                            .foregroundColor(.brownColor)
                            .kerning(3)
                    }
                    .padding(.top, 70)
                    .padding(.bottom, 30)
                    
                    HStack {
                        VStack {
                            ZStack {
                                Image("brownBoxSmall")
                                    .resizable()
                                    .frame(width: width * 0.15, height: height * 0.12)
                                HStack {
                                    Image("Rabbit_Tap")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: width * 0.035)
                                        .padding(.trailing, 10)
                                    Text("Tap")
                                        .font(.custom("Jua-Regular", size: 28))
                                        .kerning(3)
                                        .foregroundColor(.white)
                                }
                            }
                            .padding()
                            ZStack {
                                Image("brownBoxSmall")
                                    .resizable()
                                    .frame(width: width * 0.15, height: height * 0.12)
                                HStack {
                                    Image("Fox_Tap")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: width * 0.04)
                                    Text("Ignore")
                                        .font(.custom("Jua-Regular", size: 28))
                                        .kerning(3)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        Spacer()
                        Text(currentGame.description)
                            .font(.custom("Jua-Regular", size: 24))
                            .foregroundColor(.white)
                            .kerning(3)
                            .lineSpacing(5.0)
                            .padding(.horizontal)
                        Spacer()
                    }
                    .padding(.horizontal, 90)
                    
                    Spacer()
                    ButtonView(imageName: "play.fill", destination: GameView(scene: currentGame.destination), buttonColor: .white, iconColor: .brownColor, width: width * 0.08, height: height * 0.11)
                    Spacer()
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("homeBg").resizable()
            .aspectRatio( contentMode: .fill))
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    GameDescriptionView(currentGame: GameInfo(name: "Hide and Seek", description: "This game will be going on for 10 minutes. The purpose of this game is to tap the rabbits and ignore the fox. \n \nThis game will teach child to be patient and learn to ignore distraction. This game will be paused when child lose focus. and to continue the game, the child must learn to regain focus.", imageName: "homeHideAndSeek", destination: HideAndSeekScene(), mainFocus: "Focus    |    Waiting    |    Ignore Distraction"), width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
}
