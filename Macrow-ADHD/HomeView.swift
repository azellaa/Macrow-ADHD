//
//  HomeView.swift
//  Macrow-ADHD
//
//  Created by Priskilla Adriani on 18/10/23.
//

import SwiftUI

struct HomeView: View {
    @State private var currentIdx: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    
    @ObservedObject var mwmObject: MWMInstance = MWMInstance.shared
    @State private var mwmData: MWMData?
    @ObservedObject var centralManager = CentralManager()
    @State private var imageName = "headpieceDisconnect"
    
    
    #if targetEnvironment(simulator)
    
    private let games: [GameInfo] = [
        GameInfo(name: "Hide and Seek", description: "This game will be going on for 10 minutes. The purpose of this game is to tap the rabbits and ignore the fox. \n \nThis game will teach child to be patient and learn to ignore distraction. This game will be paused when child lose focus. and to continue the game, the child must learn to regain focus.", imageName: "homeHideAndSeek", destination: HideAndSeekScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)), mainFocus: "Focus    |    Waiting    |    Ignore Distraction"),
//        GameInfo(name: "Hide", description: "lorem ipsum dolores", imageName: "homeHideAndSeek", destination: HideAndSeekScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)), mainFocus: "Focus    |    Waiting    |    Ignore Distraction"),
//        GameInfo(name: "Hide and ", description: "lorem ipsum dolores", imageName: "homeHideAndSeek", destination: HideAndSeekScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)), mainFocus: "Focus    |    Waiting    |    Ignore Distraction"),
    ]
    #else
    private let games: [GameInfo] = [
        GameInfo(name: "Hide and Seek", description: "This game will be going on for 10 minutes. The purpose of this game is to tap the rabbits and ignore the fox. \n \nThis game will teach child to be patient and learn to ignore distraction. This game will be paused when child lose focus. and to continue the game, the child must learn to regain focus.", imageName: "homeHideAndSeek", destination: HideAndSeekWithHeadpiece(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)), mainFocus: "Focus    |    Waiting    |    Ignore Distraction"),
//        GameInfo(name: "Hide", description: "lorem ipsum dolores", imageName: "homeHideAndSeek", destination: HideAndSeekScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)), mainFocus: "Focus    |    Waiting    |    Ignore Distraction"),
//        GameInfo(name: "Hide and ", description: "lorem ipsum dolores", imageName: "homeHideAndSeek", destination: HideAndSeekScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)), mainFocus: "Focus    |    Waiting    |    Ignore Distraction"),
    ]
    #endif
    
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                HStack {
                    ButtonView(imageName: "chart.bar.fill", destination: EmptyView(), buttonColor: .brownColor, iconColor: .white, width: geo.size.width * 0.08, height: geo.size.height * 0.11)
                        .padding(.leading)
                        .padding()
                    Spacer()
                    Text("NECTAR")
                        .font(.custom("Jua-Regular", size: 86))
                        .foregroundColor(Color.brownColor)
                    Spacer()
                    ButtonView(imageName: self.imageName, destination: GuideView()
                        .navigationBarBackButtonHidden(), buttonColor: .brownColor, iconColor: .white, width: geo.size.width * 0.08, height: geo.size.height * 0.11)
                        .padding(.trailing)
                        .padding()
                }
                .padding(.bottom)
                
                HStack {
                    BackCarouselButton(backName: "chevron.backward", isbackButton: true, totalGames: games.count, currentIdx: $currentIdx)
                        .frame(width: geo.size.width * 0.08)
                        .opacity(currentIdx == 0 ? 0 : 1)
                    
                    Spacer()
                    
                    ZStack {
                        ForEach(0..<games.count) { index in
                            HomeItemView(dest: GameDescriptionView(currentGame: games[index], width: geo.size.width, height: geo.size.height), gameName: games[index].name, imageName: games[index].imageName)
                                .offset(x: CGFloat(index - currentIdx) * geo.size.width * 0.9 + dragOffset, y: 0)
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onEnded({ value in
                                let threshold: CGFloat = 50
                                if value.translation.width > threshold {
                                    withAnimation {
                                        currentIdx = max(0, currentIdx - 1)
                                    }
                                } else if value.translation.width < -threshold {
                                    withAnimation {
                                        currentIdx = min(games.count - 1, currentIdx + 1)
                                    }
                                }
                            })
                    )
                    
                    Spacer()
                    
                    BackCarouselButton(backName: "chevron.forward", isbackButton: false, totalGames: games.count, currentIdx: $currentIdx)
                        .frame(width: geo.size.width * 0.08)
                        .opacity(currentIdx == games.count - 1 ? 0 : 1)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("homeBg").resizable()
                .aspectRatio( contentMode: .fill))
        }
        .onReceive(mwmObject.signalStatusPublisher) { signalStatus in
            switch signalStatus {
            case 1:
                self.imageName = "headpiece1Bar"
                break
            case 2:
                self.imageName = "headpiece2Bar"
                break
            case 3:
                self.imageName = "headpiece3Bar"
                break
            case 4:
                self.imageName = "headpieceLogo"
                break
            default:
                self.imageName = "headpieceDisconnect"
                break
            }
        }
        .onChange(of: centralManager.isBluetoothOn) { isBluetoothOn in
            
            if isBluetoothOn && !mwmObject.isConnected{
                print(isBluetoothOn)
                mwmObject.mwmDevice?.scanDevice()
            }
        }

        
        
    }
}

#Preview {
    HomeView()
        .previewInterfaceOrientation(.landscapeRight)
}
